//
//  ProfileInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import FirebaseAuth
import FirebaseFirestore

class ProfileInteractor: ProfilePresenterToInteractorProtocol{
    
    var presenter: ProfileInteractorToPresenterProtocol?
    
    init(presenter: ProfileInteractorToPresenterProtocol? = nil) {
        self.presenter = presenter
        addProfileListener()
    }
    
    deinit{
        removeProfileListener()
    }
    
    func fetchProfile() {
        if let profile: UserProfileModel = UserDefaultHelper.shared.getProfile(){
            presenter?.result(result: .success(.successfullyFetchedProfile(profile)))
            return
        }
        guard let id = Auth.auth().currentUser?.uid else{return}
        NetworkManager.shared.fetchDocument(reference: .user(id)) { [weak self] (result: Result<UserProfileModel, Error>) in
            guard let self = self else{
                return
            }
            switch result{
            case .success(let profile):
                self.presenter?.result(result: .success(.successfullyFetchedProfile(profile)))
            case .failure(let error):
                self.presenter?.result(result: .failure(error))
            }
        }
    }
    
    func uploadProfilePicture(user id: String, image: UIImage) {
        
        let size = image.calculateSizeInKB()
        guard let data = size > 500 ? image.jpegData(compressionQuality: 0.5):image.jpegData(compressionQuality: 1) else{
            presenter?.result(result: .failure(CustomError.failedToUploadToStorage))
            return
        }
        FirebaseStorageManager.shared.uploadImage(data: data, reference: .profile(id)) { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let url):
                self.updateImageUrlOnUserProfile(user: id,url: url)
            case .failure(let error):
                self.presenter?.result(result: .failure(CustomError.failedToUploadToStorage))
                self.presenter?.result(result: .failure(error))
            }
        }
    }
    
    func updateImageUrlOnUserProfile(user id: String, url: URL){
        NetworkManager.shared.updateDocumentField(key: UserProfileModel.CodingKeys.profilePictureUrl.rawValue, value: url.absoluteString, document: .user(id)) { [weak self] error in
            if let error = error{
                self?.presenter?.result(result: .failure(error))
                return
            }
            NetworkManager.shared.fetchProfile(completion: nil)
        }
    }
    
    func signOut() {
        do{
            try Auth.auth().signOut()
        }catch{
            presenter?.result(result: .failure(CustomError.failedToSignOut))
        }
    }
    
    func addProfileListener(){
        NotificationCenter.default.addObserver(self, selector: #selector(userUpdatedTheirProfile), name: .userDataHasBeenUpdated, object: nil)
    }
    
    func removeProfileListener(){
        NotificationCenter.default.removeObserver(self, name: .userDataHasBeenUpdated, object: nil)
    }
    
    @objc func userUpdatedTheirProfile(notification: Notification){
        guard let profile = notification.object as? UserProfileModel else{return}
        presenter?.result(result: .success(.successfullyFetchedProfile(profile)))
    }
}

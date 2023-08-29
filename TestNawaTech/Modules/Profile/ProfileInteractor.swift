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
    
    func fetchProfile() {
        if let profile: Profile = UserDefaultHelper.shared.getProfile(){
            presenter?.result(result: .success(.successfullyFetchedProfile(profile)))
            return
        }
        guard let id = Auth.auth().currentUser?.uid else{return}
        NetworkManager.shared.fetchDocument(reference: .user(id)) { [weak self] (result: Result<Profile, Error>) in
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
        guard let data = image.pngData() else{
            presenter?.result(result: .failure(CustomError.failedToUploadToStorage))
            return
        }
        FirebaseStorageManager.shared.uploadImage(data: data, reference: .profile(id)) { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let url):
                if let profile = UserDefaultHelper.shared.getProfile(){
                    profile.profilePictureUrl = url.absoluteString
                    updateUserDataOnFirestore(profile: profile)
                }
            case .failure(let error):
                self.presenter?.result(result: .failure(CustomError.failedToUploadToStorage))
                self.presenter?.result(result: .failure(error))
            }
        }
    }
    
    func updateUserDataOnFirestore(profile: Profile){
        NetworkManager.shared.setDocument(model: profile, document: .user(profile.id ?? "")) { [weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let profile):
                if let url = URL(string: profile.profilePictureUrl ?? ""){
                    self.presenter?.result(result: .success(.successfullyUploadProfilePicture(url)))
                }
            case .failure(let failure):
                self.presenter?.result(result: .failure(failure))
            }
        }
    }
    
    func signOut() {
        do{
            try Auth.auth().signOut()
        }catch{
            presenter?.result(result: .failure(CustomError.failedToSignOut))
        }
    }
}

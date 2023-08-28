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
    
    func signOut() {
        do{
            try Auth.auth().signOut()
        }catch{
            presenter?.result(result: .failure(CustomError.failedToSignOut))
        }
    }
}

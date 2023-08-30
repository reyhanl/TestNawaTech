//
//  RegisterInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import FirebaseAuth

class AuthInteractor: AuthPresenterToInteractorProtocol{
    var presenter: AuthInteractorToPresenterProtocol?
    
    func updateUserData(token: String, email: String, id: String, balance: Double = 0) {
        NetworkManager.shared.setDocument(model: UserProfileModel(name: email.getEmailName(), id: id, profilePictureUrl: "", balance: balance), document: .user(id)) { [weak self] result in
            switch result {
            case .success(_):
                self?.presenter?.result(result: .success(.successfullyRegister(token)))
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] auth, error in
            guard let self = self else{return}
            if let error = error{
                let customError: CustomError = .failedToSignUp(error.localizedDescription)
                presenter?.result(result: .failure(customError))
                
                return
            }
            let token = auth?.user.refreshToken ?? ""
            self.updateUserData(token: token, email: email, id: auth?.user.uid ?? "", balance: 0)
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] auth, error in
            guard let self = self else{return}
            if let error = error{
                let customError: CustomError = .failedToSignUp(error.localizedDescription)
                presenter?.result(result: .failure(customError))
                return
            }
            let token = auth?.user.refreshToken ?? ""
            presenter?.result(result: .success(.successfullySignIn(token)))
        }
    }
}

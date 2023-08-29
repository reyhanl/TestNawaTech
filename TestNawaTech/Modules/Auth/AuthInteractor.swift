//
//  RegisterInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import FirebaseAuth

class AuthInteractor: AuthPresenterToInteractorProtocol{
    var presenter: AuthInteractorToPresenterProtocol?
    
    func updateUserData(email: String, id: String) {
        NetworkManager.shared.setDocument(model: Profile(name: email.getEmailName(), id: id, profilePictureUrl: ""), document: .user(id)) { result in
            switch result {
            case .success(let success):
                break
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
            self.updateUserData(email: email, id: auth?.user.uid ?? "")
            let token = auth?.user.refreshToken ?? ""
            presenter?.result(result: .success(.successfullyRegister(token)))
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

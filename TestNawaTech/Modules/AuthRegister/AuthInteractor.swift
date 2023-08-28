//
//  RegisterInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import FirebaseAuth

class AuthInteractor: AuthPresenterToInteractorProtocol{
    var presenter: AuthInteractorToPresenterProtocol?
    
    func fetchData() {
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

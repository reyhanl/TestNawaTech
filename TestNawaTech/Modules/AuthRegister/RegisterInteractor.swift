//
//  RegisterInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import FirebaseAuth

class RegisterInteractor: RegisterPresenterToInteractorProtocol{
    var presenter: RegisterInteractorToPresenterProtocol?
    
    func fetchData() {
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] auth, error in
            guard let self = self else{return}
            if let error = error{
                presenter?.result(result: .failure(error))
                return
            }
            let token = auth?.user.refreshToken ?? ""
            presenter?.result(result: .success(.successfullyRegister(token)))
        }
    }
}

//
//  RegisterPresenter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import Foundation
import UIKit

class AuthPresenter: AuthViewToPresenterProtocol{
    var view: AuthPresenterToViewProtocol?
    var interactor: AuthPresenterToInteractorProtocol?
    var router: AuthPresenterToRouterProtocol?
    
    func register(email: String, password: String) {
        interactor?.register(email: email, password: password)
    }
    
    func signIn(email: String, password: String) {
        interactor?.signIn(email: email, password: password)
    }
    
    func goToSignIn(from vc: UIViewController) {
        router?.goToSignIn(from: vc)
    }
    
    func goToSignUp(from vc: UIViewController) {
        router?.goToSignUp(from: vc)
    }
}

extension AuthPresenter: AuthInteractorToPresenterProtocol{
    
    func result(result: Result<AuthSuccessType, Error>) {
        view?.result(result: result)
    }
}

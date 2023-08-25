//
//  RegisterPresenter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import Foundation
import UIKit

class RegisterPresenter: RegisterViewToPresenterProtocol{
    var view: RegisterPresenterToViewProtocol?
    var interactor: RegisterPresenterToInteractorProtocol?
    var router: RegisterPresenterToRouterProtocol?
    
    func register(email: String, password: String) {
        interactor?.register(email: email, password: password)
    }
}

extension RegisterPresenter: RegisterInteractorToPresenterProtocol{
    
    func result(result: Result<RegisterDetailSuccessType, Error>) {
        view?.result(result: result)
    }
}

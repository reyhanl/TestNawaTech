//
//  ProfilePresenter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import Foundation
import UIKit

class ProfilePresenter: ProfileViewToPresenterProtocol{
    var view: ProfilePresenterToViewProtocol?
    var interactor: ProfilePresenterToInteractorProtocol?
    var router: ProfilePresenterToRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchProfile()
    }
}

extension ProfilePresenter: ProfileInteractorToPresenterProtocol{
    
    func result(result: Result<ProfileSuccessType, Error>) {
        view?.result(result: result)
    }
}

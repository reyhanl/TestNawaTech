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
    
    func viewWillAppear() {
        interactor?.fetchProfile()
    }
    
    func signOut() {
        interactor?.signOut()
    }
    
    func uploadProfilePicture(user id: String, image: UIImage) {
        interactor?.uploadProfilePicture(user: id, image: image)
    }
    
    func goToStatisticVC(from vc: UIViewController) {
        router?.goToStatisticVC(from: vc)
    }
    
    func presentImagePicker(from vc: UIViewController){
        router?.presentImagePicker(from: vc)
    }
    
    func topUp(vc: UIViewController) {
        router?.goToTopUpVC(vc: vc)
    }
}

extension ProfilePresenter: ProfileInteractorToPresenterProtocol{
    
    func result(result: Result<ProfileSuccessType, Error>) {
        view?.result(result: result)
    }
}

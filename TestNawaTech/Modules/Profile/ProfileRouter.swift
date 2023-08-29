//
//  ProfileRouter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import Foundation
import UIKit

class ProfileRouter: ProfilePresenterToRouterProtocol{
    
    static func makeComponent() -> ProfileViewController {
        var presenter: ProfileViewToPresenterProtocol & ProfileInteractorToPresenterProtocol = ProfilePresenter()
        let view = ProfileViewController()
        var interactor: ProfilePresenterToInteractorProtocol = ProfileInteractor()
        let router: ProfilePresenterToRouterProtocol = ProfileRouter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
                
        return view
    }
    
    func goToStatisticVC(from vc: UIViewController) {
        
    }
    
    func presentImagePicker(from vc: UIViewController) {
        guard let vc = vc as? ProfileViewController else{return}
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = vc
        vc.present(imagePicker, animated: true)
    }
}

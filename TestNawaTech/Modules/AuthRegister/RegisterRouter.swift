//
//  RegisterRouter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import Foundation
import UIKit

class RegisterRouter: RegisterPresenterToRouterProtocol{
    static func makeComponent() -> RegisterViewController {
        var presenter: RegisterViewToPresenterProtocol & RegisterInteractorToPresenterProtocol = RegisterPresenter()
        let view = RegisterViewController()
        var interactor: RegisterPresenterToInteractorProtocol = RegisterInteractor()
        let router: RegisterPresenterToRouterProtocol = RegisterRouter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    func goToSignIn(from vc: UIViewController) {
        let signInVC = RegisterRouter.makeComponent()
        vc.navigationController?.pushViewController(signInVC, animated: true)
    }
}

//
//  RegisterRouter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import Foundation
import UIKit

class AuthRouter: AuthPresenterToRouterProtocol{
    static func makeComponent(for type: AuthType) -> AuthViewController {
        var presenter: AuthViewToPresenterProtocol & AuthInteractorToPresenterProtocol = AuthPresenter()
        let view = AuthViewController()
        var interactor: AuthPresenterToInteractorProtocol = AuthInteractor()
        let router: AuthPresenterToRouterProtocol = AuthRouter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        view.auth = type
        
        return view
    }
    
    func goToSignIn(from vc: UIViewController) {
        let signInVC = AuthRouter.makeComponent(for: .signIn)
        vc.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func goToSignUp(from vc: UIViewController){
        let signInVC = AuthRouter.makeComponent(for: .signUp)
        vc.navigationController?.pushViewController(signInVC, animated: true)
    }
}

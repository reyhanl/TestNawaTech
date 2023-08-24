//
//  HomeRouter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation
import UIKit

class HomeRouter: HomePresenterToRouterProtocol{
    static func makeComponent() -> HomeViewController {
        var presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let view = HomeViewController()
        var interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router: HomePresenterToRouterProtocol = HomeRouter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    
    func goToMotorcycleDetailPage(_ view: UIViewController, motorcycle: Motorcycle) {
        let vc = MotorcycleDetailRouter.makeComponent(motorcycle: motorcycle)

        view.navigationController?.pushViewController(vc, animated: true)
    }
}

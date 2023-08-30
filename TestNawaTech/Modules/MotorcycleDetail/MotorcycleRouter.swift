//
//  MotorcycleDetailRouter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation
import UIKit

class MotorcycleDetailRouter: MotorcycleDetailPresenterToRouterProtocol{
    static func makeComponent(motorcycle: MotorcycleModel) -> MotorcycleDetailViewController {
        var presenter: MotorcycleDetailViewToPresenterProtocol & MotorcycleDetailInteractorToPresenterProtocol = MotorcycleDetailPresenter()
        let view = MotorcycleDetailViewController()
        var interactor: MotorcycleDetailPresenterToInteractorProtocol = MotorcycleDetailInteractor()
        let router: MotorcycleDetailPresenterToRouterProtocol = MotorcycleDetailRouter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
        
        view.motorcycle = motorcycle
        return view
    }
}

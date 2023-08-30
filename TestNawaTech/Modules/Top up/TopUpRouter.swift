//
//  TopUpRouter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 30/08/23.
//

import Foundation
import UIKit

class TopUpRouter: TopUpPresenterToRouterProtocol{
    
    static func makeComponent() -> TopUpViewController {
        var presenter: TopUpViewToPresenterProtocol & TopUpInteractorToPresenterProtocol = TopUpPresenter()
        let view = TopUpViewController()
        var interactor: TopUpPresenterToInteractorProtocol = TopUpInteractor()
        let router: TopUpPresenterToRouterProtocol = TopUpRouter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
                
        return view
    }
}

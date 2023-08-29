//
//  HistoryRouter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import Foundation
import UIKit

class HistoryRouter: HistoryPresenterToRouterProtocol{
    
    static func makeComponent() -> HistoryViewController {
        var presenter: HistoryViewToPresenterProtocol & HistoryInteractorToPresenterProtocol = HistoryPresenter()
        let view = HistoryViewController()
        var interactor: HistoryPresenterToInteractorProtocol = HistoryInteractor()
        let router: HistoryPresenterToRouterProtocol = HistoryRouter()
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        view.presenter = presenter
        interactor.presenter = presenter
                
        return view
    }
}

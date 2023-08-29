//
//  HistoryPresenter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import Foundation
import UIKit

class HistoryPresenter: HistoryViewToPresenterProtocol{
    var view: HistoryPresenterToViewProtocol?
    var interactor: HistoryPresenterToInteractorProtocol?
    var router: HistoryPresenterToRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchHistory()
    }
    
    func getChartData(purchases: [Purchase]) {
        interactor?.getChartData(purchases: purchases)
    }
}

extension HistoryPresenter: HistoryInteractorToPresenterProtocol{
    
    func result(result: Result<HistorySuccessType, Error>) {
        view?.result(result: result)
    }
}

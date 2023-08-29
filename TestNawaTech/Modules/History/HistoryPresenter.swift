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
    
    func presentTableViewOptions(vc: UIViewController, purchase: Purchase) {
        var title: String = ""
        var message: String = ""
        
        let okAction = UIAlertAction(title: "Oke", style: .default)
        let cancelOrderAction = UIAlertAction(title: "Cancel this order", style: .destructive, handler: { [weak self] _ in
            self?.interactor?.cancelOrder(purchase: purchase)
        })
        
        switch purchase.enumStatus {
        case .waitingForConfirmation:
            title = "Order is sent to seller"
            message = "Please wait a little bit longer, the seller will notify you soon"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            alertController.addAction(okAction)
            alertController.addAction(cancelOrderAction)
            vc.present(alertController, animated: true)
        case .cancelled:
            title = "Order is cancelled"
            message = "The ordered has been canceled by you or the seller"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            alertController.addAction(okAction)
            vc.present(alertController, animated: true)
        case .finished:
            title = "Order is completed"
            message = "Thank you for shopping with us! Buy more from this seller if you like them"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            alertController.addAction(okAction)
            vc.present(alertController, animated: true)
        case .none:
            break
        }
    }
}

extension HistoryPresenter: HistoryInteractorToPresenterProtocol{
    
    func result(result: Result<HistorySuccessType, Error>) {
        view?.result(result: result)
    }
}

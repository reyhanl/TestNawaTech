//
//  TopUpPresenter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 30/08/23.
//

import Foundation
import UIKit

class TopUpPresenter: TopUpViewToPresenterProtocol{

    var view: TopUpPresenterToViewProtocol?
    var interactor: TopUpPresenterToInteractorProtocol?
    var router: TopUpPresenterToRouterProtocol?
    
    func presentConfirmation(vc: UIViewController, topUp: TopUpModel) {
        var title: String = ""
        var message: String = ""
        
        let okAction = UIAlertAction(title: "Oke", style: .default) { [weak self] alert in
            self?.interactor?.topUp(topUp: topUp)
        }
        let cancelOrderAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        title = "Top up confirmation"
        message = "Do you want to top up IDR \(topUp.amount?.giveAutoFinanceAbbreviations() ?? "")"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(okAction)
        alertController.addAction(cancelOrderAction)
        vc.present(alertController, animated: true)
    }
    
    func viewDidLoad() {
        interactor?.fetchTopUp()
    }
    
    func topUp(topUp: TopUpModel) {
        guard let vc = view as? UIViewController else{
            view?.result(result: .failure(CustomError.somethingWentWrong))
            return
        }
        presentConfirmation(vc: vc, topUp: topUp)
    }
    
    func refreshData() {
        interactor?.refreshData()
    }
}

extension TopUpPresenter: TopUpInteractorToPresenterProtocol{
    
    func result(result: Result<TopUpSuccessType, Error>) {
        view?.result(result: result)
    }
}

//
//  MotorcycleDetailInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation

class MotorcycleDetailInteractor: MotorcycleDetailPresenterToInteractorProtocol{
    var presenter: MotorcycleDetailInteractorToPresenterProtocol?
    
    init(presenter: MotorcycleDetailInteractorToPresenterProtocol? = nil) {
        self.presenter = presenter
    }
    
    func fetchData() {
    }
    
    func purchase(motorcycle: MotorcycleModel) {
        guard let id = UserDefaultHelper.shared.getProfile()?.id else{
            presenter?.result(result: .failure(CustomError.somethingWentWrong))
            return
        }
        let uuid = UUID().uuidString
        let purchase: PurchaseModel = .init(buyerId: id, motorcycleId: motorcycle.id ?? "", date: Date().getString(format: Date.defaultDateFormat), total: motorcycle.price, status: PurchaseStatus.waitingForConfirmation.rawValue, transactionId: uuid)
        NetworkManager.shared.purchase(purchase: purchase) { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(_):
                presenter?.result(result: .success(.purchase))
            case .failure(let error):
                presenter?.result(result: .failure(error))
            }
        }
    }
    
    @objc func logOut(){
    }
}

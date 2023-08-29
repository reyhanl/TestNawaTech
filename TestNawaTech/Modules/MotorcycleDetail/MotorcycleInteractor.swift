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
    
    func purchase(motorcycle: Motorcycle) {
        guard let id = UserDefaultHelper.shared.getProfile()?.id else{
            presenter?.result(result: .failure(CustomError.somethingWentWrong))
            return
        }
        let purchase: Purchase = .init(buyerId: id, motorcycleId: motorcycle.id ?? "", date: Date().getString(format: Date.defaultDateFormat), total: motorcycle.price)
        NetworkManager.shared.purchase(purchase: purchase) { [weak self] result in
            guard let self = self else{return}
            self.presenter?.result(result: .success(.purchase))
        }
    }
    
    @objc func logOut(){
    }
}

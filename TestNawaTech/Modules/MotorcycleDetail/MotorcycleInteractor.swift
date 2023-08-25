//
//  MotorcycleDetailInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation

class MotorcycleDetailInteractor: MotorcycleDetailPresenterToInteractorProtocol{
    var presenter: MotorcycleDetailInteractorToPresenterProtocol?
    
    func fetchData() {
    }
    
    func purchase(motorcycle: Motorcycle) {
        let purchase: Purchase = .init(buyerId: "random", motorcycleId: motorcycle.id ?? "", date: Date().getString(format: "dd/MM/YYYY"), total: motorcycle.price)
        NetworkManager.shared.purchase(purchase: purchase) { [weak self] result in
            guard let self = self else{return}
            self.presenter?.result(result: .success(.purchase))
        }
    }
}

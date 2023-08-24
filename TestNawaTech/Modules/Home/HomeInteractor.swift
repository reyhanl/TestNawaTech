//
//  HomeInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation

class HomeInteractor: HomePresenterToInteractorProtocol{
    var presenter: HomeInteractorToPresenterProtocol?
    
    func fetchData() {
        NetworkManager.shared.fetchCollection(reference: .getMotorcycles) { [weak self] (result: Result<[Motorcycle], Error>) in
            guard let self = self else{return}
            switch result {
            case .success(let motorcycles):
                self.presenter?.result(result: .success(.fetchData(motorcycles)))
            case .failure(let error):
                self.presenter?.result(result: .failure(error))
            }
        }
    }
}

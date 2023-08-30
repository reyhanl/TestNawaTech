//
//  TopUpInteractor.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 30/08/23.
//

import FirebaseAuth
import FirebaseFirestore

class TopUpInteractor: TopUpPresenterToInteractorProtocol{
    
    var presenter: TopUpInteractorToPresenterProtocol?
    
    func fetchTopUp() {
        NetworkManager.shared.fetchCollection(reference: .topUps) { [weak self] (result: Result<[TopUpModel], Error>) in
            switch result{
            case .success(let topUps):
                self?.presenter?.result(result: .success(.successfullyFetchedTopUp(topUps.sorted(by: {$0.amount ?? 0 < $1.amount ?? 0.1}))))
            case .failure(let error):
                self?.presenter?.result(result: .failure(error))
            }
        }
    }
    
    func topUp(topUp: TopUpModel) {
        NetworkManager.shared.topUp(topUp: topUp) { [weak self] error in
            if let error = error{
                self?.presenter?.result(result: .failure(error))
            }
            self?.presenter?.result(result: .success(.successfullyTopUp(topUp)))
        }
    }
    
    
    func refreshData() {
        fetchTopUp()
    }
    
}

//
//  MotorcycleDetailPresenter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation
import UIKit

class MotorcycleDetailPresenter: MotorcycleDetailViewToPresenterProtocol{
    var view: MotorcycleDetailPresenterToViewProtocol?
    var interactor: MotorcycleDetailPresenterToInteractorProtocol?
    var router: MotorcycleDetailPresenterToRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func refreshData(){
        interactor?.fetchData()
    }
    
    func purchase(motorcycle: MotorcycleModel) {
        interactor?.purchase(motorcycle: motorcycle)
    }
}

extension MotorcycleDetailPresenter: MotorcycleDetailInteractorToPresenterProtocol{
    
    func result(result: Result<MotorcycleDetailSuccessType, Error>) {
        view?.result(result: result)
    }
    
    func signOut(){
        view?.signOut()
    }
}

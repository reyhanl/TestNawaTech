//
//  HomePresenter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation
import UIKit

class HomePresenter: HomeViewToPresenterProtocol{
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchData()
    }
    
    func refreshData(){
        interactor?.fetchData()
    }
    
    func goToMotorcycleDetailPage(_ view: UIViewController, motorcycle: Motorcycle) {
        router?.goToMotorcycleDetailPage(view, motorcycle: motorcycle)
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol{
    
    func result(result: Result<HomeSuccessType, Error>) {
        view?.result(result: result)
    }
}

//
//  HomePresenter.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation

class HomePresenter: HomeViewToPresenterProtocol{
    
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchData()
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol{
    
    func result(result: Result<HomeSuccessType, Error>) {
        view?.result(result: result)
    }
}

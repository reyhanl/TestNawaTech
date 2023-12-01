//
//  HomePresenterMock.swift
//  TestNawaTechUITests
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation
import UIKit

class HomePresenterMock: HomeViewToPresenterProtocol{
    var view: HomePresenterToViewProtocol?
    
    var router: HomePresenterToRouterProtocol?
    
    func viewDidLoad() {
        let motorcycles = MockDataProvider.generateMotorcycles()
        view?.result(result: .success(.fetchData(motorcycles)))
    }
    
    func goToMotorcycleDetailPage(_ view: UIViewController, motorcycle: MotorcycleModel) {
        router?.goToMotorcycleDetailPage(view, motorcycle: motorcycle)
    }
    
    func refreshData() {
        var motorcycles = MockDataProvider.generateMotorcycles()
        motorcycles.remove(at: 0)
        view?.result(result: .success(.fetchData(motorcycles)))
    }
}

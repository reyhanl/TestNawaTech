//
//  HomeProtocol.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import UIKit

protocol HomePresenterToViewProtocol{
    var presenter: HomeViewToPresenterProtocol? {get set}
    func result(result: Result<HomeSuccessType, Error>)
}

protocol HomeViewToPresenterProtocol{
    var view: HomePresenterToViewProtocol? {get set}
    var router: HomePresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func goToMotorcycleDetailPage(_ view: UIViewController, motorcycle: Motorcycle)
    func refreshData()
}

protocol HomePresenterToInteractorProtocol{
    var presenter: HomeInteractorToPresenterProtocol? {get set}
    func fetchData()
}


protocol HomeInteractorToPresenterProtocol{
    var interactor: HomePresenterToInteractorProtocol? {get set}
    func result(result: Result<HomeSuccessType, Error>)
}

protocol HomePresenterToRouterProtocol{
    static func makeComponent() -> HomeViewController
    func goToMotorcycleDetailPage(_ view: UIViewController, motorcycle: Motorcycle)
}

enum HomeSuccessType{
    case fetchData([Motorcycle])
}

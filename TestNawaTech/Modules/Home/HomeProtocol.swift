//
//  HomeProtocol.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import Foundation

protocol HomePresenterToViewProtocol{
    var presenter: HomeViewToPresenterProtocol? {get set}
    func result(result: Result<HomeSuccessType, Error>)
}

protocol HomeViewToPresenterProtocol{
    var view: HomePresenterToViewProtocol? {get set}
    var router: HomePresenterToRouterProtocol? {get set}
    func viewDidLoad()
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
}

enum HomeSuccessType{
    case fetchData([Motorcycle])
}

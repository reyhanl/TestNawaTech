//
//  MotorcycleDetailProtocol.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import UIKit

protocol MotorcycleDetailPresenterToViewProtocol{
    var presenter: MotorcycleDetailViewToPresenterProtocol? {get set}
    func result(result: Result<MotorcycleDetailSuccessType, Error>)
}

protocol MotorcycleDetailViewToPresenterProtocol{
    var view: MotorcycleDetailPresenterToViewProtocol? {get set}
    var router: MotorcycleDetailPresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func refreshData()
}

protocol MotorcycleDetailPresenterToInteractorProtocol{
    var presenter: MotorcycleDetailInteractorToPresenterProtocol? {get set}
    func fetchData()
}


protocol MotorcycleDetailInteractorToPresenterProtocol{
    var interactor: MotorcycleDetailPresenterToInteractorProtocol? {get set}
    func result(result: Result<MotorcycleDetailSuccessType, Error>)
}

protocol MotorcycleDetailPresenterToRouterProtocol{
    static func makeComponent(motorcycle: Motorcycle) -> MotorcycleDetailViewController
}

enum MotorcycleDetailSuccessType{
    case fetchData([Motorcycle])
}

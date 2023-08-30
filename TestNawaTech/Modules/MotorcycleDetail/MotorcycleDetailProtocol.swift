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
    func signOut()
}

protocol MotorcycleDetailViewToPresenterProtocol{
    var view: MotorcycleDetailPresenterToViewProtocol? {get set}
    var router: MotorcycleDetailPresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func refreshData()
    func purchase(motorcycle: MotorcycleModel)
}

protocol MotorcycleDetailPresenterToInteractorProtocol{
    var presenter: MotorcycleDetailInteractorToPresenterProtocol? {get set}
    func fetchData()
    func purchase(motorcycle: MotorcycleModel)
}


protocol MotorcycleDetailInteractorToPresenterProtocol{
    var interactor: MotorcycleDetailPresenterToInteractorProtocol? {get set}
    func result(result: Result<MotorcycleDetailSuccessType, Error>)
    func signOut()
}

protocol MotorcycleDetailPresenterToRouterProtocol{
    static func makeComponent(motorcycle: MotorcycleModel) -> MotorcycleDetailViewController
}

enum MotorcycleDetailSuccessType{
    case purchase
}

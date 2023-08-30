//
//  TopUpProtocol.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 30/08/23.
//

import UIKit

protocol TopUpPresenterToViewProtocol{
    var presenter: TopUpViewToPresenterProtocol? {get set}
    func result(result: Result<TopUpSuccessType, Error>)
}

protocol TopUpViewToPresenterProtocol{
    var view: TopUpPresenterToViewProtocol? {get set}
    var router: TopUpPresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func topUp(topUp: TopUpModel)
    func refreshData()
}

protocol TopUpPresenterToInteractorProtocol{
    var presenter: TopUpInteractorToPresenterProtocol? {get set}
    func fetchTopUp()
    func topUp(topUp: TopUpModel)
    func refreshData()
}


protocol TopUpInteractorToPresenterProtocol{
    var interactor: TopUpPresenterToInteractorProtocol? {get set}
    func result(result: Result<TopUpSuccessType, Error>)
}

protocol TopUpPresenterToRouterProtocol{
    static func makeComponent() -> TopUpViewController
}

enum TopUpSuccessType{
    case successfullyFetchedTopUp([TopUpModel])
    case successfullyTopUp(TopUpModel)
}

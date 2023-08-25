//
//  RegisterProtocol.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import UIKit

protocol RegisterPresenterToViewProtocol{
    var presenter: RegisterViewToPresenterProtocol? {get set}
    func result(result: Result<RegisterDetailSuccessType, Error>)
}

protocol RegisterViewToPresenterProtocol{
    var view: RegisterPresenterToViewProtocol? {get set}
    var router: RegisterPresenterToRouterProtocol? {get set}
    func register(email: String, password: String)
//    func purchase(motorcycle: Register)
}

protocol RegisterPresenterToInteractorProtocol{
    var presenter: RegisterInteractorToPresenterProtocol? {get set}
    func register(email: String, password: String)
//    func purchase(motorcycle: Register)
}


protocol RegisterInteractorToPresenterProtocol{
    var interactor: RegisterPresenterToInteractorProtocol? {get set}
    func result(result: Result<RegisterDetailSuccessType, Error>)
}

protocol RegisterPresenterToRouterProtocol{
    static func makeComponent() -> RegisterViewController
}

enum RegisterDetailSuccessType{
    case successfullyRegister(String)
}

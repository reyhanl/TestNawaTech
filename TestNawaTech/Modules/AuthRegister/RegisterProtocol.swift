//
//  RegisterProtocol.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 25/08/23.
//

import UIKit

protocol AuthPresenterToViewProtocol{
    var presenter: AuthViewToPresenterProtocol? {get set}
    func result(result: Result<AuthSuccessType, Error>)
}

protocol AuthViewToPresenterProtocol{
    var view: AuthPresenterToViewProtocol? {get set}
    var router: AuthPresenterToRouterProtocol? {get set}
    func register(email: String, password: String)
    func signIn(email: String, password: String)
    func goToSignIn(from vc: UIViewController)
    func goToSignUp(from vc: UIViewController)
//    func purchase(motorcycle: Register)
}

protocol AuthPresenterToInteractorProtocol{
    var presenter: AuthInteractorToPresenterProtocol? {get set}
    func register(email: String, password: String)
    func signIn(email: String, password: String)
//    func purchase(motorcycle: Register)
}


protocol AuthInteractorToPresenterProtocol{
    var interactor: AuthPresenterToInteractorProtocol? {get set}
    func result(result: Result<AuthSuccessType, Error>)
}

protocol AuthPresenterToRouterProtocol{
    static func makeComponent(for type: AuthType) -> AuthViewController
    func goToSignIn(from vc: UIViewController)
    func goToSignUp(from vc: UIViewController)
}

enum AuthSuccessType{
    case successfullyRegister(String)
    case successfullySignIn(String)
}

enum AuthType{
    case signIn
    case signUp
}

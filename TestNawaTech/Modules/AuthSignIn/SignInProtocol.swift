//
//  SignInProtocol.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 26/08/23.
//

import UIKit

protocol SignInPresenterToViewProtocol{
    var presenter: SignInViewToPresenterProtocol? {get set}
    func result(result: Result<SignInSuccessType, Error>)
}

protocol SignInViewToPresenterProtocol{
    var view: SignInPresenterToViewProtocol? {get set}
    var router: SignInPresenterToRouterProtocol? {get set}
    func register(email: String, password: String)
    func goToSignIn(from vc: UIViewController)
//    func purchase(motorcycle: SignIn)
}

protocol SignInPresenterToInteractorProtocol{
    var presenter: SignInInteractorToPresenterProtocol? {get set}
    func register(email: String, password: String)
//    func purchase(motorcycle: SignIn)
}


protocol SignInInteractorToPresenterProtocol{
    var interactor: SignInPresenterToInteractorProtocol? {get set}
    func result(result: Result<SignInSuccessType, Error>)
}

protocol SignInPresenterToRouterProtocol{
    static func makeComponent() -> RegisterViewController
    func goToSignIn(from vc: UIViewController)
}

enum SignInSuccessType{
    case successfullySignIn(String)
}

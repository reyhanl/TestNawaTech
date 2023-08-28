//
//  ProfileProtocol.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 28/08/23.
//

import UIKit

protocol ProfilePresenterToViewProtocol{
    var presenter: ProfileViewToPresenterProtocol? {get set}
    func result(result: Result<ProfileSuccessType, Error>)
}

protocol ProfileViewToPresenterProtocol{
    var view: ProfilePresenterToViewProtocol? {get set}
    var router: ProfilePresenterToRouterProtocol? {get set}
    func viewDidLoad()
}

protocol ProfilePresenterToInteractorProtocol{
    var presenter: ProfileInteractorToPresenterProtocol? {get set}
    func fetchProfile()
}


protocol ProfileInteractorToPresenterProtocol{
    var interactor: ProfilePresenterToInteractorProtocol? {get set}
    func result(result: Result<ProfileSuccessType, Error>)
}

protocol ProfilePresenterToRouterProtocol{
    static func makeComponent() -> ProfileViewController
}

enum ProfileSuccessType{
    case successfullyFetchedProfile(Profile)
}

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
    func signOut()
    func uploadProfilePicture(user id: String, image: UIImage)
    func goToStatisticVC(from vc: UIViewController)
    func presentImagePicker(from vc: UIViewController)
}

protocol ProfilePresenterToInteractorProtocol{
    var presenter: ProfileInteractorToPresenterProtocol? {get set}
    func fetchProfile()
    func uploadProfilePicture(user id: String, image: UIImage)
    func signOut()
}


protocol ProfileInteractorToPresenterProtocol{
    var interactor: ProfilePresenterToInteractorProtocol? {get set}
    func result(result: Result<ProfileSuccessType, Error>)
}

protocol ProfilePresenterToRouterProtocol{
    static func makeComponent() -> ProfileViewController
    func goToStatisticVC(from vc: UIViewController)
    func presentImagePicker(from vc: UIViewController)
}

enum ProfileSuccessType{
    case successfullyFetchedProfile(Profile)
    case successfullyUploadProfilePicture(URL)
}

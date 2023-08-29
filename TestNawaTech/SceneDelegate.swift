//
//  SceneDelegate.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 24/08/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var firstOpen: Bool = true
    var listener: AuthStateDidChangeListenerHandle?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        if CommandLine.arguments.contains("HomeUITests") {
            let vc = HomeRouter.makeComponent()
            let homePresenter = HomePresenterMock()
            homePresenter.router = vc.presenter?.router
            homePresenter.view = vc
            vc.presenter = homePresenter
            let navigationController = CustomNavigationController(rootViewController: vc)
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }else{
            redirectUser(scene: scene)
            addAuthStateListener(scene: scene)
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func addAuthStateListener(scene: UIScene){
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AuthStateDidChange, object: Auth.auth(), queue: nil) { _ in
            self.redirectUser(scene: scene)
        }
    }
    
    func goToHome(scene: UIScene){
        guard let windowScene = (scene as? UIWindowScene) else{return}
        let vc = HomeRouter.makeComponent()
        let tabBarController = UITabBarController()
        let homeNavigationController = CustomNavigationController(rootViewController: vc)
        let tabBarItem = UITabBarItem(title: "Catalog", image: UIImage.init(systemName: "rectangle.on.rectangle"), selectedImage: UIImage.init(systemName: "rectangle.fill.on.rectangle.fill"))
        vc.tabBarItem = tabBarItem
        tabBarController.addChild(homeNavigationController)
        
        let profileVC = ProfileRouter.makeComponent()
        let profileNavigationController = CustomNavigationController(rootViewController: profileVC)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage.init(systemName: "person"), selectedImage: UIImage.init(systemName: "person.fill"))
        profileVC.tabBarItem = profileTabBarItem
        tabBarController.addChild(profileNavigationController)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func goToRegister(scene: UIScene){
        guard let windowScene = (scene as? UIWindowScene)
        else { return }
        let vc = AuthRouter.makeComponent(for: .signIn)
        let navigationController = CustomNavigationController(rootViewController: vc)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func redirectUser(scene: UIScene){
        if let user = Auth.auth().currentUser{
            NetworkManager.shared.fetchDocument(reference: .user(user.uid)) { (result: Result<Profile, Error>) in
                switch result{
                case .success(let user):
                    UserDefaultHelper.shared.storeProfile(user)
                case .failure(let error):
                    break
                }
                self.goToHome(scene: scene)
            }
        }else{
            if self.firstOpen{
                self.goToRegister(scene: scene)
            }else{
                self.presentSignInInvalid(scene: scene)
            }
        }
        self.firstOpen = false
    }
    
    func presentSignInInvalid(scene: UIScene){
        guard let windowScene = (scene as? UIWindowScene),
              let tabBar = windowScene.keyWindow?.rootViewController as? UITabBarController,
              let navCon = tabBar.viewControllers?[tabBar.selectedIndex] as? UINavigationController,
              let vc = navCon.visibleViewController
        else { return }
        let alertVC = CustomAlertViewController(isCancelAble: false, title: "session is invalid", description: "You need to sign in again", actionText: "OK", cancelText: "")
        alertVC.modalPresentationStyle = .fullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.delegate = self
        vc.present(alertVC, animated: true)
    }
}

extension SceneDelegate: CustomAlertDelegate{
    func userTapOk() {
        guard let scene = window?.windowScene?.session.scene, let windowScene = (scene as? UIWindowScene),
              let vc = windowScene.keyWindow?.rootViewController
        else { return }
        vc.dismiss(animated: true) { [weak self] in
            guard let self = self else{return}
            self.goToRegister(scene: scene)
        }
    }
    
    func userTapOnCancel() {
        guard let scene = window?.windowScene?.session.scene, let windowScene = (scene as? UIWindowScene),
              let vc = windowScene.keyWindow?.rootViewController
        else { return }
        vc.dismiss(animated: true)
    }
}

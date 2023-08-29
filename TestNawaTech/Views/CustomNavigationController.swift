//
//  CustomNavigationController.swift
//  TestNawaTech
//
//  Created by reyhan muhammad on 29/08/23.
//

import UIKit

class CustomNavigationController: UINavigationController{
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        tabBarController?.tabBar.isHidden = viewControllers.count > 2
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        tabBarController?.tabBar.isHidden = false
        return super.popToRootViewController(animated: animated)
    }
    
}

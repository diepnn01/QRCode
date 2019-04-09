//
//  RootRouter.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class RootRouter {
    
    enum MainRouteStoryboard {
        static let Login = "Login"
        static let Tabbar = "Tabbar"
    }
    
    var rootViewController: UINavigationController?
    
    /** Replaces root view controller. You can specify the replacment animation type.
     If no animation type is specified, there is no animation */
    func setRootViewController(controller: UIViewController, animatedWithOptions: UIView.AnimationOptions?) {
        guard let window = UIApplication.shared.keyWindow else {
            fatalError("No window in app")
        }
        
        rootViewController = UINavigationController(rootViewController: controller)
        guard let rootViewController = rootViewController else {
            return
        }
        rootViewController.isNavigationBarHidden = true
        if let animationOptions = animatedWithOptions, window.rootViewController != nil {
            window.rootViewController = rootViewController
            UIView.transition(with: window, duration: 0.33, options: animationOptions, animations: {
            }, completion: nil)
        } else {
            window.rootViewController = rootViewController
        }
    }
    
    func loadMainAppStructure() {
        
        if SessionManager.shared.user == nil {
            guard let loginController = UIStoryboard.loadViewControler(MainRouteStoryboard.Login, nameController: LoginViewController.className) as? LoginViewController else {
                return
            }
            setRootViewController(controller: loginController, animatedWithOptions: nil)
        } else {
            guard let tabbarController = UIStoryboard.loadViewControler(MainRouteStoryboard.Tabbar, nameController: TabbarViewController.className) as? TabbarViewController else {
                return
            }
            
            setRootViewController(controller: tabbarController, animatedWithOptions: nil)
        }
    }
}

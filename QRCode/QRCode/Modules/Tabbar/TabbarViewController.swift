//
//  TabbarViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = activeColor
        
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        
        var arrayVC = [UIViewController]()
        arrayVC.append(getViewControllerForTabbarItem(type: .Wallet))
        arrayVC.append(getViewControllerForTabbarItem(type: .Scan))
        arrayVC.append(getViewControllerForTabbarItem(type: .Profile))
        
        viewControllers = arrayVC
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width, height: tabBar.frame.height), cornerRadius: 15)
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        tabBar.layer.mask = mask
//        
//    }
    
    private func getViewControllerForTabbarItem(type: TabbarItems) -> UIViewController {
        let itemController = TabbarItem(itemType: type)
        itemController.controller.tabBarItem.title = type.itemTitle
        itemController.controller.tabBarItem.image = UIImage(named: itemController.image)

        let naviViewController = UINavigationController(rootViewController: itemController.controller)
        naviViewController.isNavigationBarHidden = true
        
        return naviViewController
    }
}

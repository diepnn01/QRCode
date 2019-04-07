//
//  TabbarItem.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

enum TabbarItems: String {
    case Wallet = "Wallet"
    case Scan = "Scan"
    case Profile = "Profile"
    
    var itemTitle: String {
        switch self {
        case .Wallet:
            return "Wallet"
        case .Scan:
            return "Scan"
        case .Profile:
            return "Profile"
        }
    }
}

struct TabbarItem {
    
    let controller: UIViewController
    let image: String

    init(itemType: TabbarItems) {
        
        switch itemType {
        case .Wallet:
            controller = UIStoryboard.loadViewControler(itemType.rawValue, nameController: WalletViewController.className) ?? UIViewController()
            image = "icon_wallet_disable"
        case .Scan:
            controller = UIStoryboard.loadViewControler(itemType.rawValue, nameController: ScanViewController.className) ?? UIViewController()
            image = "icon_scan_disabled"
        case .Profile:
            controller = UIStoryboard.loadViewControler(itemType.rawValue, nameController: ProfileViewController.className) ?? UIViewController()
            image = "icon_profile_disabled"
        }
        
    }
}

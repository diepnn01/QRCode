//
//  UIStoryboard+Extension.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static func loadViewControler(_ nameStoryBoard: String, nameController: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: nameStoryBoard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: nameController)
        return controller
    }
}

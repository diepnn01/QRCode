//
//  UITableView+Extension.swift
///  QRCode
//
//  Created by Diep Nguyen on 4/8/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell(nibName: String...) {
        
        for name in nibName {
            self.register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
        }
    }
}

//
//  NSObject.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

extension NSObject {
    
    // Name Of class
    class var className: String {
        let name = String(describing: self)
        return name
    }
}

//
//  String+Extension.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localize(arguments: String...) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }
    
    func localize(arguments: CVarArg...) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }
}

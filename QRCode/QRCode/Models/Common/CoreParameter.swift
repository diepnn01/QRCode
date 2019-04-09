//
//  CoreParameter.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/4/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

protocol CoreParameter {
    func toDictionary() -> [String: AnyObject]
}

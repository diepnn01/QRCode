//
//  ProfileDetailItem.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

struct ProfileDetailItem {

    var title: String
    var content: String?
    var placeHolder: String?
    
    init(title: String, content: String?, placeHolder: String) {
        self.title = title
        self.content = content
        self.placeHolder = placeHolder
    }
}

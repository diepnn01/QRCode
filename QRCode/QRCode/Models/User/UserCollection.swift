//
//  UserCollection.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/10/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class UserCollection: CoreResponse {
    
    var objectList = [User]()
    
    init(data: [String : Any]?) {
        guard let items = data?["items"] as? [[String: Any]] else {
            return
        }
        objectList = items.map({ (item:[String: Any]) -> User in
            return User(data: item)
        })
    }
}

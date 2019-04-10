//
//  TransactionCollection.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/10/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class TransactionCollection: CoreResponse {
    
    var objectList = [Transaction]()
    
    init(data: [String : Any]?) {
        guard let objects = data?["items"] as? [[String: Any]] else {
            return
        }
        
        objectList = objects.map({ (item:[String: Any]) -> Transaction in
            return Transaction(data: item)
        })
    }
}

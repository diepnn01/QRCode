//
//  Product.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/10/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

struct Product: CoreParameter {
    
    var productName: String?
    var productImage: String?
    var transactionContent: String?
    var amount: String?
    var currency: String?
    var productID: String?
    var store: String?
    var userID: String?
    var review: Bool = false
    var refund: Bool = false
    
    func toDictionary() -> [String : AnyObject] {
        var params = [String: Any]()
        if let temp = currency {
            params["currency"] = temp
        }
        
        if let temp = amount {
            params["amount"] = temp
        }
        
        if let temp = productName {
            params["productName"] = temp
        }
        
        if let temp = transactionContent {
            params["transactionContent"] = temp
        }
        
        if let temp = store {
            params["store"] = temp
        }
        
        if let temp = userID {
            params["userID"] = temp
        }
        
        if let temp = productImage {
            params["productImage"] = temp
        }
        
        if let temp = productID {
            params["productID"] = temp
        }
        
        params["review"] = review
        params["refund"] = refund
        
        return params as [String : AnyObject]
    }
}

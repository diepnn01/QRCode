//
//  Transaction.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/10/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

enum TransactionStatus {
    case done
    case refund
    case review
}

struct Transaction: CoreResponse, CoreParameter {
    
    var productName: String?
    var productImage: String?
    var transactionContent: String?
    var amount: String?
    var currency: String?
    var productID: String?
    var transactionID: String?
    var createdDate: String?
    var store: String?
    var userID: String?
    var status: TransactionStatus = .done
    
    
    init(data: [String : Any]?) {
        productID = data?["productID"] as? String
        productName = data?["productName"] as? String
        productImage = data?["productImage"] as? String
        amount = data?["amount"] as? String
        currency = data?["currency"] as? String
        transactionContent = data?["transactionContent"] as? String
        transactionID = data?["transactionID"] as? String
        
        if let date = data?["timeCreated"] as? Date {
            print(date.getStringDate(format: .server))
            let serverDateString = date.getStringDate(format: .server)
            let clientDate = Date.dateFormatter.date(from: serverDateString)
            createdDate = clientDate?.getStringDate(format: .client)
        }
        store = data?["store"] as? String
        userID = data?["userID"] as? String
        
        if let refund = data?["refund"] as? Bool, refund {
            status = .refund
        } else if let review = data?["review"] as? Bool, review {
            status = .review
        }
    }
    
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
        
        return params as [String : AnyObject]
    }
}

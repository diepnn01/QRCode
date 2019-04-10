//
//  WalletService.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/10/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation
import KumulosSDK

final class WalletSevice {
    
    enum MethodName {
        static let transactionHistory = "transactionHistory"
        static let addTransaction = "addTransaction"
    }
    
    /*
     * Return list transactions that belong to current user
     */
    func getTransactionHistory(userID: String) -> ServiceRequest<TransactionCollection> {
        let request = ServiceRequest<TransactionCollection>()
        let params = ["userID": userID]
        Kumulos.call(MethodName.transactionHistory, parameters: params as Dictionary<String, AnyObject>).success { (response, _) in
            request.handleResponseJSONArray(response: response)
            }.failure { (error, _) in
                request.handleError(error: error)
        }
        return request
    }
    
    /*
     * When user implement any transaction, we will call api to store it into server
     */
    func addNewTransaction(transaction: Product) -> ServiceRequest<EmptyResponse> {
        let request = ServiceRequest<EmptyResponse>()
        Kumulos.call(MethodName.addTransaction, parameters: transaction.toDictionary()).success { (response, _) in
            request.handleEmptyResponse(response: response)
            }.failure { (error, _) in
                request.handleError(error: error)
        }
        return request
    }
    
}

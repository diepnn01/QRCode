//
//  WalletViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/7/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class WalletViewModel {
    
    private let service = WalletSevice()
    private var transactions = [String: [Transaction]]()
    private var sections = [String]()
    
    var errorMassage: DataBinding<String>?
    var getTransactionCompleted: DataBinding<Bool>?
    
    //MARK:- Public methods
    init() {
        errorMassage = DataBinding(value: "")
        getTransactionCompleted = DataBinding()
    }
    
    func getTransactionHistory() {
        guard let userID = SessionManager.shared.userID else {
            return
        }
        transactions.removeAll()
        sections.removeAll()
        
        Spinner.shared.show()
        service.getTransactionHistory(userID: userID).cloudResponse { [weak self](collection: TransactionCollection) in
            self?.classifyData(objects: collection.objectList)
            self?.getTransactionCompleted?.value = true
            }.cloudError { [weak self](errorMsg: String, _: Int?) in
                self?.errorMassage?.value = errorMsg
            }.finally {
                Spinner.shared.dismiss()
        }
    }
    
    func numberOfSection() -> Int {
        return sections.count
    }
    
    func numberOfRow(at sectionIndex: Int) -> Int {
        let sectionTitle = sections[sectionIndex]
        return transactions[sectionTitle]?.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> Transaction? {
        let sectionTitle = sections[indexPath.section]
        guard let numberItems = transactions[sectionTitle] else {
            return nil
        }
        
        guard indexPath.row >= 0 && indexPath.row < numberItems.count else {
            return nil
        }

        return numberItems[indexPath.row]
    }
    
    func sectionTitle(at section: Int) -> String? {
        guard section >= 0 && section < sections.count else {
            return nil
        }
        return sections[section]
    }
    
    //MARK:- Private method
    private func classifyData(objects: [Transaction]) {
        objects.forEach { (transaction: Transaction) in
            let createdDate = transaction.createdDate!
            
            if !transactions.contains(where: {$0.key == createdDate}) {
                sections.append(createdDate)
                transactions[createdDate] = [transaction]
            } else {
                transactions[transaction.createdDate!]?.append(transaction)
            }
        }
    }
}

//
//  ProfileDetailViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class ProfileDetailViewModel {

    //MARK:- Private properties
    private var listItems = [ProfileDetailItem]()
    private let service = UserService()
    
    //MARK:- Public methods
    init() {
        prepareData()
    }
    
    func numberOfRows() -> Int {
        return listItems.count
    }
    
    func item(atIndex row: Int) -> ProfileDetailItem? {
        guard row >= 0 && row < listItems.count else {
            return nil
        }
        return listItems[row]
    }
    
    //MARK:- Private methods
    private func prepareData() {
        guard let user = SessionManager.shared.user?.value else {
            return
        }
        
        listItems.append(ProfileDetailItem(title: "Email", content: user.email ?? ""))
        listItems.append(ProfileDetailItem(title: "Mobile", content: user.phoneNumber ?? ""))
        
        if let firstName = user.firstName, let lastName = user.lastName {
            listItems.append(ProfileDetailItem(title: "FullName", content: "\(firstName) \(lastName)"))
        }
    }
}

//
//  ProfileViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/8/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class ProfileViewModel {
 
    private var listItems = [ProfileItem]()
    
    //MARK:- Public methods
    init() {
        prepareData()
    }
    
    func numberOfRows() -> Int {
        return listItems.count
    }
    
    func item(atIndex row: Int) -> ProfileItem? {
        guard row >= 0 && row < listItems.count else {
            return nil
        }
        return listItems[row]
    }
    
    //MARK:- Private methods
    private func prepareData() {
        listItems.append(ProfileItem(iconName: "icon_notification", title: "Notifications"))
        listItems.append(ProfileItem(iconName: "icon_user_data_outlined", title: "Personal Information"))
        listItems.append(ProfileItem(iconName: "icon_shield_outlined", title: "Security Settings"))
        listItems.append(ProfileItem(iconName: "icon_help_outlined", title: "Help & Support"))
        listItems.append(ProfileItem(iconName: "icon_legal_docs_outlined", title: "Term of Use"))
    }
}

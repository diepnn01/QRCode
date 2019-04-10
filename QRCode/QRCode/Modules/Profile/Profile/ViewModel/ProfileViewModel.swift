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
    private let service = UserService()
    
    //MARK:- Public properties
    var errorMessage: DataBinding<String> = DataBinding(value: "")
    
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
    
    func getProfileDetail() {
        guard let userID = SessionManager.shared.userID else {
            return
        }
        Spinner.shared.show()
        service.getProfileDetail(userID: userID).cloudResponse { (user: User) in
            SessionManager.shared.user?.value = user
            }.cloudError { [weak self](errorMsg: String, _: Int?) in
                self?.errorMessage.value = errorMsg
            }.finally {
                Spinner.shared.dismiss()
        }
    }
    
    //MARK:- Private methods
    private func prepareData() {
    
        listItems.append(ProfileItem(iconName: "icon_notification", title: "profile.notifications".localize()))
        listItems.append(ProfileItem(iconName: "icon_user_data_outlined", title: "profile.personal.information".localize()))
        listItems.append(ProfileItem(iconName: "icon_shield_outlined", title: "profile.security.settings".localize()))
        listItems.append(ProfileItem(iconName: "icon_help_outlined", title: "profile.help.support".localize()))
        listItems.append(ProfileItem(iconName: "icon_legal_docs_outlined", title: "profile.team.of.use".localize()))
    }
}

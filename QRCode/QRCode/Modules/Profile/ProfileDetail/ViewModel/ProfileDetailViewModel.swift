//
//  ProfileDetailViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class ProfileDetailViewModel {
    
    enum ProfileContentType: Int {
        case firstName = 0, lastName = 2, phone = 3
    }
    
    //MARK:- Private properties
    private var listItems = [ProfileDetailItem]()
    private let service = UserService()
    
    //MARK:- Public properties
    var editUser: User?
    var errorMessage: DataBinding<String>
    
    //MARK:- Public methods
    init() {
        editUser = SessionManager.shared.user?.value
        errorMessage = DataBinding(value: "")
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
    
    func updateNewData(content: String?, index: Int) {
        guard let type = ProfileContentType(rawValue: index) else {
            return
        }
        
        switch type {
        case .firstName:
            editUser?.firstName = content
        case .lastName:
            editUser?.lastName = content
        case .phone:
            editUser?.phoneNumber = content
        }
    }
    
    func hasChanged() -> Bool {
        guard let oldUser = SessionManager.shared.user?.value,
              let newUser = editUser else {
            return false
        }
        
        return oldUser != newUser
    }
    
    func updateProfile() {
        guard let user = editUser else {
            return
        }

        Spinner.shared.show()
        service.updateProfile(params: user).cloudResponse { [weak self](response) in
            SessionManager.shared.user?.value = self?.editUser
            }.cloudError { [weak self](errMsg: String, _: Int?) in
                self?.errorMessage.value = errMsg
            }.finally {
                Spinner.shared.dismiss()
        }
    }
    
    //MARK:- Private methods
    private func prepareData() {
        guard let user = SessionManager.shared.user?.value else {
            return
        }
        
        listItems.append(ProfileDetailItem(title: "profile.item.firstname".localize(), content: user.firstName, placeHolder: "profile.placeholder.firstname".localize()))
        listItems.append(ProfileDetailItem(title: "profile.item.lastname".localize(), content: user.lastName, placeHolder: "profile.placeholder.lastname".localize()))
        listItems.append(ProfileDetailItem(title: "profile.item.email".localize(), content: user.email, placeHolder: "profile.placeholder.email".localize()))
        listItems.append(ProfileDetailItem(title: "profile.item.mobile".localize(), content: user.phoneNumber, placeHolder: "profile.placeholder.mobile".localize()))
    }
}

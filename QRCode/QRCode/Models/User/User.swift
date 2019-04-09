//
//  User.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

class User: CoreResponse, CoreParameter {
    
    var email: String?
    var firstName: String?
    var lastName: String?
    var userID: Int?
    var avatarUrl: String?
    var phoneNumber: String?
    
    required init(data: [String : Any]?) {
        
        guard let items = data?["items"] as? [[String: Any]], let object = items.first else {
            return
        }
        
        email = object["email"] as? String
        firstName = object["firstName"] as? String
        lastName = object["lastName"] as? String
        userID = object["userID"] as? Int
        avatarUrl = object["avatarUrl"] as? String
        phoneNumber = object["phoneNumber"] as? String
    }
    
    func toDictionary() -> [String : AnyObject] {
        var params = [String: Any]()
        
        if let email = email {
            params["email"] = email
        }
        
        if let firstName = firstName {
            params["firstName"] = firstName
        }
        
        if let lastName = lastName {
            params["lastName"] = lastName
        }
        
        if let avatar = avatarUrl {
            params["avatarUrl"] = avatar
        }
        
        if let userId = userID {
            params["userID"] = userId
        }
        
        if let phone = phoneNumber {
            params["phoneNumber"] = phone
        }
        
        return params as [String : AnyObject]
    }
    
    func fromDictionary(_ dict: [String: AnyObject]) -> User {
        self.userID = dict["userID"] as? Int
        self.firstName = dict["firstName"] as? String
        self.phoneNumber = dict["phoneNumber"] as? String
        self.lastName = dict["lastName"] as? String
        self.avatarUrl = dict["avatarUrl"] as? String
        self.email = dict["email"] as? String
        
        return self
    }
    
    public func toJsonString() -> String? {
        let dict = toDictionary()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            if let string = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                return string as String
            }
            return nil
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    public func fromJsonString(_ jsonString: String) {
        
        var dict: [String: AnyObject]?
        
        if jsonString != "" {
            if let data = jsonString.data(using: String.Encoding.utf8) {
                do {
                    dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
                } catch {
                    dict = nil
                }
            }
            if let myDict = dict {
                _ = fromDictionary(myDict)
            }
        }
    }
}

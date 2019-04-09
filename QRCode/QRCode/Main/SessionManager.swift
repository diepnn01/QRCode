//
//  SessionManager.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//
import KeychainSwift

final class SessionManager {
    
    static let shared = SessionManager()
    
    fileprivate class Keywords {
        static let User = "user"
    }
    
    private let keychain = KeychainSwift()
    
    var user: User? {
        get {
            guard let json = keychain.get(Keywords.User), !json.isEmpty else {
                return nil
            }
            
            let userTemp = User(data: nil)
            userTemp.fromJsonString(json)
            return userTemp
        }
        
        set {
            guard let newUser = newValue, let temp = newUser.toJsonString() else {
                keychain.delete(Keywords.User)
                return
            }
            
            keychain.set(temp, forKey: Keywords.User )
        }
    }
}

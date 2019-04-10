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
        static let userID = "userID"
    }
    
    private let keychain = KeychainSwift()
    
    var userID: String? {
        get {
            guard let userTemp = keychain.get(Keywords.userID) else {
                return nil
            }
            return userTemp
        }
        
        set {
            guard let newUser = newValue else {
                keychain.delete(Keywords.userID)
                return
            }
            
            keychain.set(newUser, forKey: Keywords.userID )
        }
    }
    
    var user: User? {
        didSet {
            guard let newUserID = user?.userID else {
                return
            }
            userID = "\(newUserID)"
        }
    }
}

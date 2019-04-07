//
//  LoginViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class LoginViewController: BaseViewController {

    enum SegueIndenfier {
        static let tabbar = "show tabbar"
        static let signUp = "show sign up"
    }
    
    //MARK:- Outlets
    @IBOutlet weak var emailInputText: CustomInputTextView!
    @IBOutlet weak var passwordInputText: CustomInputTextView!
    
    
    //MARK:- Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Actions
    @IBAction private func actionLogin(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIndenfier.tabbar, sender: nil)
    }
    
    @IBAction private func actionSignup(_ sender: UIButton) {
        
    }
    
    @IBAction private func actionForgotPassword(_ sender: UIButton) {
    }
    
    
}

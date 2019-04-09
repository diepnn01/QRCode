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
    @IBOutlet private weak var emailInputText: CustomInputTextView!
    @IBOutlet private weak var passwordInputText: CustomInputTextView!
    
    //MARK:- Public properties
    private let viewModel = LoginViewModel()
    
    //MARK:- Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubcribers()
    }
    
    //MARK:- Private methods
    private func setupSubcribers() {
        viewModel.errorMessage.bind(hdl: { [weak self](errorMsg) in
            self?.showMessage(content: errorMsg)
        })
        
        viewModel.loginCompleted.bind(hdl: { [weak self](isSuccess) in
            guard isSuccess else {
                return
            }
            self?.performSegue(withIdentifier: SegueIndenfier.tabbar, sender: nil)
        })
    }
    
    //MARK:- Actions
    @IBAction private func actionLogin(_ sender: UIButton) {
        view.endEditing(true)
        viewModel.login(email: emailInputText.text, password: passwordInputText.text)
    }
}

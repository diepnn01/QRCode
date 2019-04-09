//
//  SignUpViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class SignUpViewController: BaseViewController {

    enum SegueIndenfier {
        static let tabbar = "show tabbar"
    }
    
    //MARK:- Outlets
    @IBOutlet private weak var inputTextEmail: CustomInputTextView!
    @IBOutlet private weak var inputTextPassword: CustomInputTextView!
    @IBOutlet private weak var labelTermOfUse: UILabel!
    @IBOutlet private weak var inputTextFirstName: CustomInputTextView!
    @IBOutlet private weak var inputTextLastName: CustomInputTextView!
    @IBOutlet private weak var buttonSignUp: UIButton!
    
    //MARK:- Private properties
    private let viewModel = SignUpViewModel()
    
    //MARK:- Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.signupCompleted.subcribe { [weak self](isCompleted: Bool) in
            guard isCompleted else {
                return
            }
            self?.performSegue(withIdentifier: SegueIndenfier.tabbar, sender: nil)
        }
        
        viewModel.errorMessage.subcribe { [weak self](errorMsg: String) in
            guard !errorMsg.isEmpty else {
                return
            }
            self?.showMessage(title: "common.error".localize(), content: errorMsg)
        }
    }
    
    //MARK:- Actions
    @IBAction private func actionSignup(_ sender: UIButton) {
        view.endEditing(true)
        
        gatherData()
        guard viewModel.validateCredentials() else {
            return
        }
        viewModel.signUp()
    }
    
    private func gatherData() {
        viewModel.emailViewModel.data.value = inputTextEmail.text
        viewModel.passwordViewModel.data.value = inputTextPassword.text
        viewModel.userNameViewModel.firstName.value = inputTextFirstName.text
        viewModel.userNameViewModel.lastName.value = inputTextLastName.text
    }
    
    @IBAction private func actionLogin(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func switchValueChanged(_ sender: UISwitch) {
        buttonSignUp.isEnabled = sender.isOn
        buttonSignUp.backgroundColor = sender.isOn ? UIColor.colorFromHex("FEC013") : .lightGray
    }
    
}

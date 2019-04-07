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
    
    //MARK:- Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    //MARK:- Actions
    @IBAction func actionSignup(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIndenfier.tabbar, sender: nil)
    }
    
    @IBAction func actionLogin(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
    }
    
}

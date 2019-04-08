//
//  PaymentViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/8/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class PaymentViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet private weak var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewContainer.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
    
    //MARK:- Actions
    @IBAction private func actionBack(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.router.rootViewController?.popViewController(animated: true)
    }
}

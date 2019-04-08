//
//  PaymentPopupViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class PaymentPopupViewController: UIViewController {

    @IBOutlet private weak var viewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.55)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewContainer.roundCorners(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 20)
    }
    
    @IBAction private func actionOK(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
}

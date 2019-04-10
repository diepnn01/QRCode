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
    @IBOutlet weak var labelTotalAmount: UILabel!
    @IBOutlet weak var labelSubTotal: UILabel!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelStore: UILabel!
    @IBOutlet weak var buttonPay: UIButton!
    
    private let viewModel = PaymentViewModel()
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.product = product
        setupUI()
        setupSubcribe()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewContainer.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
    
    private func setupSubcribe() {
        
        viewModel.addTransactionCompleted.subcribe { [weak self](isCompleted: Bool) in
            guard isCompleted else {
                return
            }
            NotificationCenter.default.post(name: .addTransactionSuccess, object: nil)
            self?.performSegue(withIdentifier: "show popup confirm", sender: nil)
        }
        
        viewModel.errorMessage.subcribe { [weak self](errorMsg: String) in
            guard !errorMsg.isEmpty else {
                return
            }
            
            self?.showMessage(title: "common.error".localize(), content: errorMsg)
        }
    }
    
    func setupUI() {
        
        labelProductName.text = product?.productName
        labelStore.text = product?.store
        labelSubTotal.text = "\(product?.currency ?? "")\(product?.amount ?? "") USD"
        
        let total = (Double(product?.amount ?? "0.0") ?? 0) + (Double("5.00") ?? 0)
        labelTotalAmount.text = "\(product?.currency ?? "")\(total)"
        
        buttonPay.setTitle("\(product?.currency ?? "")\(total)", for: .normal)
    }
    
    //MARK:- Actions
    @IBAction private func actionBack(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.router.rootViewController?.popViewController(animated: true)
    }
    
    @IBAction private func actionPay(_ sender: UIButton) {
        viewModel.addTransaction()
    }
    
}

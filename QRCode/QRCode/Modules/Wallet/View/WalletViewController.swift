//
//  WalletViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class WalletViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet private weak var viewTransactionHistory: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewTransactionHistory.roundCorners(corners: [.topRight, .topLeft], radius: 12)
    }
    
    //MARK:- Private method
    private func setupView() {
        
//        tableView.registerCell(nibName: TransactionHistoryCell.identifier)
    }
}

extension WalletViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionHistoryCell.identifier, for: indexPath) as? TransactionHistoryCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

extension WalletViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        
        let titleLabel = UILabel(frame: headerView.frame)
        titleLabel.textAlignment = .center
        titleLabel.text = "04.19.2019"
        titleLabel.textColor = UIColor.colorFromHex("797879")
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

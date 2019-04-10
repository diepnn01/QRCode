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

    //MARK:- Private properties
    private let viewModel = WalletViewModel()
    
    //MARK:- Public
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.getTransactionHistory()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewTransactionHistory.roundCorners(corners: [.topRight, .topLeft], radius: 20)
    }
    
    //MARK:- Private method
    private func setupView() {
        tableView.disableStickyHeader()
        
        viewModel.getTransactionCompleted?.subcribe(hdl: { [weak self](isCompleted: Bool) in
            guard isCompleted else {
                return
            }
            self?.tableView.reloadData()
        })
    }
}

extension WalletViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionHistoryCell.identifier, for: indexPath) as? TransactionHistoryCell else {
            return UITableViewCell()
        }
        
        cell.transaction = viewModel.item(at: indexPath)
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
        titleLabel.text = viewModel.sectionTitle(at: section)
        titleLabel.textColor = UIColor.colorFromHex("797879")
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

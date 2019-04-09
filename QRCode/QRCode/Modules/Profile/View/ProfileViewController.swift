//
//  ProfileViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class ProfileViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelFullName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    
    private let viewModel = ProfileViewModel()
    
    //MARK: Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileItemCell.identifier, for: indexPath) as? ProfileItemCell else {
            return UITableViewCell()
        }
        
        guard let item = viewModel.item(atIndex: indexPath.row) else {
            return cell
        }
        
        cell.model = item
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

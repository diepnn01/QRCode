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
    @IBOutlet private weak var imageViewAvatar: UIImageView!
    @IBOutlet private weak var labelFullName: UILabel!
    @IBOutlet private weak var labelPhone: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var containerView: UIView!
    
    //MARK:- Private properties
    private let viewModel = ProfileViewModel()
    
    //MARK:- Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubcribes()
        viewModel.getProfileDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
    }
    
    private func setupSubcribes() {
        SessionManager.shared.user?.subcribe(hdl: { [weak self](user: User) in
            guard let userID = user.userID else {
                return
            }
            
            if let image = ImageService.getSavedImage(named: "\(userID)") {
                self?.imageViewAvatar.image = image
            } else {
                self?.imageViewAvatar.image = UIImage(named: "default_user")
            }
            
            self?.labelPhone.text = user.phoneNumber
            self?.labelFullName.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
        })
        
        viewModel.errorMessage.subcribe { [weak self](errMsg: String) in
            guard !errMsg.isEmpty else {
                return
            }
            self?.showMessage(title: "common.error".localize(), content: errMsg)
        }
    }
    
    //MARK:- Private methods
    private func showProfileDetail() {
        guard let destinationVC = UIStoryboard.loadViewControler("Profile", nameController: ProfileDetailViewController.className) as? ProfileDetailViewController else {
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.router.rootViewController?.pushViewController(destinationVC, animated: true)
    }
} 

//MARK:- UITableViewDataSource
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

//MARK:- UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            showProfileDetail()
        default:
            break
        }
    }
}

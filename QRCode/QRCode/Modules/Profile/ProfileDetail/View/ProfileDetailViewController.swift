//
//  ProfileDetailViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class ProfileDetailViewController: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet private weak var imageViewAvatar: UIImageView!
    
    //MARK:- Private properties
    private let viewModel = ProfileDetailViewModel()
    
    //MARK:- Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubcribes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewContainer.roundCorners(corners: [.topLeft, .topRight], radius: 12)
    }
    
    //MARK:- Private methods
    private func setupUI() {
        guard let userID = SessionManager.shared.userID else {
            return
        }
        
        if let image = ImageService.getSavedImage(named: "\(userID)") {
            imageViewAvatar.image = image
        } else {
            imageViewAvatar.image = UIImage(named: "default_user")
        }
    }
    
    private func setupSubcribes() {

        viewModel.errorMessage.subcribe { [weak self](errMsg: String) in
            guard !errMsg.isEmpty else {
                return
            }
            self?.showMessage(title: "common.error".localize(), content: errMsg)
        }
    }
    
    private func moveToPreviousScreen() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.router.rootViewController?.popViewController(animated: true)
    }
    
    //MARK:- Actions
    @IBAction private func actionBack(_ sender: UIButton) {
        view.endEditing(true)
        
        guard viewModel.hasChanged() else {
            moveToPreviousScreen()
            return
        }
        
        let alertViewController = UIAlertController(title: "common.warning".localize(), message: "profile.message.warning.lost.data".localize(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "common.ok".localize(), style: .default) { [weak self](action) in
            self?.viewModel.updateProfile()
        }
        
        let noAction = UIAlertAction(title: "common.no".localize(), style: .cancel) { [weak self](action) in
            self?.moveToPreviousScreen()
        }
        alertViewController.addAction(noAction)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    @IBAction private func actionChooseImage(_ sender: UIButton) {
        showSheetGetImage()
    }
}

//MARK:- UIImagePickerControllerDelegate
extension ProfileDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage, let userID = SessionManager.shared.userID else {
            return
        }
        
        if ImageService.saveImage(image: selectedImage, fileName: userID) {
            imageViewAvatar.image = ImageService.getSavedImage(named: userID)
            var user = SessionManager.shared.user?.value
            user?.avatarUrl = userID
            SessionManager.shared.user?.value = user
        }
        
        self.dismiss(animated: true, completion: {
            UIApplication.shared.statusBarStyle = .lightContent
        })
    }
}

//MARK:- UITableViewDataSource
extension ProfileDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDetailTableViewCell.identitfier, for: indexPath) as? ProfileDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.fillData(model: viewModel.item(atIndex: indexPath.row), enableEdit: indexPath.row != 2)
        cell.onValueChanged = { [weak self](newContent) in
            self?.viewModel.updateNewData(content: newContent, index: indexPath.row)
        }
        return cell
    }
}

//MARK:- UITableViewDelegate
extension ProfileDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

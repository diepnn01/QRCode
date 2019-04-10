//
//  ProfileDetailViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class ProfileDetailViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet private weak var imageViewAvatar: UIImageView!
    
    private let viewModel = ProfileDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewContainer.roundCorners(corners: [.topLeft, .topRight], radius: 12)
    }
    
    //MARK:- Actions
    @IBAction private func actionBack(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.router.rootViewController?.popViewController(animated: true)
    }
    
    @IBAction private func actionChooseImage(_ sender: UIButton) {
        showSheetGetImage()
    }
}

//MARK:- UIImagePickerControllerDelegate
extension ProfileDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        guard let userID = SessionManager.shared.userID else {
            return
        }
        
        if ImageService.saveImage(image: selectedImage, fileName: userID) {
            imageViewAvatar.image = ImageService.getSavedImage(named: userID)
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
        cell.item = viewModel.item(atIndex: indexPath.row)
        return cell
    }
}

//MARK:- UITableViewDelegate
extension ProfileDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

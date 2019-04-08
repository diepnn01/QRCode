//
//  ScanViewController.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

final class ScanViewController: BaseViewController {

    //MARK:- Outlets
    @IBOutlet private weak var scannerView: UIView!
    
    //MARK:- Private properties
    private var scanner: QRCodeScanner?
    
    //MARK:- Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner = QRCodeScanner(withViewController: self, view: self.scannerView, codeOutputHandler: { [weak self](code: String) in
            self?.handleCode(code: code)
        })
        
        if let scanner = self.scanner {
            scanner.requestCaptureSessionStartRunning()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scanner?.requestCaptureSessionStartRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scanner?.requestCaptureSessionStopRunning()
    }
    
    private func handleCode(code: String) {
        guard let destinationVC = UIStoryboard.loadViewControler("Scan", nameController: PaymentViewController.className) as? PaymentViewController else {
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.router.rootViewController?.pushViewController(destinationVC, animated: true)
    }
}

//MARK:- AVCaptureMetadataOutputObjectsDelegate
extension ScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        scanner?.scannerDelegete(output, didOutput: metadataObjects, from: connection)
    }
}

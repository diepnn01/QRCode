//
//  QRCodeScanner.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/8/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

final class QRCodeScanner {
    
    //MARK:-  Private properties
    private var viewController: UIViewController
    private var captureSession: AVCaptureSession?
    private var codeOutputHandler: (_ code: String) -> Void
    
    // MARK:- Public methods
    init(withViewController viewController: UIViewController,
         view: UIView,
         codeOutputHandler: @escaping ((String) -> Void)) {
        self.viewController = viewController
        self.codeOutputHandler = codeOutputHandler
        
        if let captureSession = self.createCaptureSession() {
            self.captureSession = captureSession
            let previewLayer = createPreviewLayer(withCaptureSession: captureSession, view: view)
            view.layer.addSublayer(previewLayer)
        }
    }
    
    func requestCaptureSessionStartRunning() {
        guard let captureSession = self.captureSession else {
            return
        }
        
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func requestCaptureSessionStopRunning() {
        
        guard let captureSession = self.captureSession else {
            return
        }
        
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func scannerDelegete(_ output: AVCaptureMetadataOutput,
                         didOutput meteObjects: [AVMetadataObject],
                         from connection: AVCaptureConnection) {
        requestCaptureSessionStopRunning()
        
        if let metaDataObject = meteObjects.first {
            guard let readableObject = metaDataObject as? AVMetadataMachineReadableCodeObject else {
                return
            }
            
            guard let stringValue = readableObject.stringValue else {
                return
            }
            
            codeOutputHandler(stringValue)
        }
    }
    
    //MARK: - Private methods
    
    private func createCaptureSession() -> AVCaptureSession? {
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return nil
        }
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            let metaDataOutput = AVCaptureMetadataOutput()
            
            // Add meta data input
            if captureSession.canAddInput(deviceInput) {
                captureSession.addInput(deviceInput)
            } else {
                return nil
            }
            
            // Add meta data output
            if captureSession.canAddOutput(metaDataOutput) {
                captureSession.addOutput(metaDataOutput)
                if let viewController = viewController as? AVCaptureMetadataOutputObjectsDelegate {
                    metaDataOutput.setMetadataObjectsDelegate(viewController, queue: .main)
                    metaDataOutput.metadataObjectTypes = [.qr]
                }
            } else {
                return nil
            }
            
        } catch {
            return nil
        }
        
        return captureSession
    }
    
    private func createPreviewLayer(withCaptureSession captureSession: AVCaptureSession,
                                    view: UIView) -> AVCaptureVideoPreviewLayer {

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        return previewLayer
        
    }
}

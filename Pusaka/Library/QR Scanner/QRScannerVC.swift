//
//  QRScannerVC.swift
//  Pusaka
//
//  Created by Steven Bong on 25/11/18.
//  Copyright © 2018 Beneran Indonesia. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var topbar: UIView!

    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView  : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureView() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDuoCamera], mediaType: AVMediaType.video, position: .back)
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession?.addInput(input)
            
            let captureMetaDataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetaDataOutput)
            
            captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession!.startRunning()
            
            view.bringSubviewToFront(messageLabel)
            view.bringSubviewToFront(topbar)
        } catch let error {
            print(error)
        }
    }

}




















































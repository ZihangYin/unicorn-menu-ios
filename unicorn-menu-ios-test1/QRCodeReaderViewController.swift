//
//  QRReaderViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/23/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation


protocol QRCodeReaderDelegate: class {
    func reader(reader: QRCodeReaderViewController, didScanResult result: String)
    func readerDidCancel(reader: QRCodeReaderViewController)
}

class QRCodeReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    private var cameraView: QRCodeReaderView = QRCodeReaderView()
    private var cancelButton: UIButton = UIButton()
    
    private var defaultDevice: AVCaptureDevice? = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    private var frontDevice: AVCaptureDevice?   = {
        for device in AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) {
            if let _device = device as? AVCaptureDevice {
                if _device.position == AVCaptureDevicePosition.Front {
                    return _device
                }
            }
        }
        
        return nil
        }()
    
    private lazy var defaultDeviceInput: AVCaptureDeviceInput? = {
        if let _defaultDevice = self.defaultDevice {
            return AVCaptureDeviceInput(device: _defaultDevice, error: nil)
        }
        
        return nil
        }()
    
    private lazy var frontDeviceInput: AVCaptureDeviceInput?  = {
        if let _frontDevice = self.frontDevice {
            return AVCaptureDeviceInput(device: _frontDevice, error: nil)
        }
        return nil
        }()
    
    private var metadataOutput: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    private var session: AVCaptureSession = AVCaptureSession()
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        return AVCaptureVideoPreviewLayer(session: self.session)
    }()
    
    weak var delegate: QRCodeReaderDelegate?
    var completionBlock: ((String?) -> ())?
    
    required init(cancelButtonTitle: String) {
        super.init()
        
        configureDefaultComponents()
        setupUIComponentsWithCancelButtonTitle(cancelButtonTitle)
        setupAutoLayoutConstraints()
        
        view.backgroundColor = UIColor.blackColor()
        
        cameraView.layer.insertSublayer(previewLayer, atIndex: 0)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startScanning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        stopScanning()
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        previewLayer.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureDefaultComponents() {
        session.addOutput(metadataOutput)
        
        if let _defaultDeviceInput = defaultDeviceInput {
            session.addInput(defaultDeviceInput)
        }
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        if let _availableMetadataObjectTypes = metadataOutput.availableMetadataObjectTypes as? [String] {
            if _availableMetadataObjectTypes.filter({ $0 == AVMetadataObjectTypeQRCode }).count > 0 {
                metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            }
        }
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        if previewLayer.connection != nil && previewLayer.connection.supportsVideoOrientation {
            previewLayer.connection.videoOrientation = .Portrait
        }
    }

    private func setupUIComponentsWithCancelButtonTitle(cancelButtonTitle: String) {
        cameraView.clipsToBounds = true
        cameraView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(cameraView)
        
        cancelButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        cancelButton.setTitle(cancelButtonTitle, forState: .Normal)
        cancelButton.titleLabel!.font = UIFont(name: "ProximaNova-Bold", size: 18)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        cancelButton.addTarget(self, action: "cancelAction:", forControlEvents: .TouchUpInside)
        view.addSubview(cancelButton)
    }
    
    private func setupAutoLayoutConstraints() {
        let views = ["cameraView": cameraView, "cancelButton": cancelButton]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-60-[cameraView]-20-[cancelButton(40)]-80-|", options: .allZeros, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[cameraView]-|", options: .allZeros, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[cancelButton]-|", options: .allZeros, metrics: nil, views: views))
    }
    
    private func startScanning() {
        if !session.running {
            session.startRunning()
        }
    }
    
    private func stopScanning() {
        if session.running {
            session.stopRunning()
        }
    }
    
    // MARK: - Catching Button Events
    
    func cancelAction(button: UIButton) {
        stopScanning()
        
        if let _completionBlock = completionBlock {
            _completionBlock(nil)
        }
        
        delegate?.readerDidCancel(self)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for current in metadataObjects {
            if let _readableCodeObject = current as? AVMetadataMachineReadableCodeObject {
                if _readableCodeObject.type == AVMetadataObjectTypeQRCode {
                    stopScanning()
                    
                    let scannedResult: String = _readableCodeObject.stringValue
                    
                    if let _completionBlock = completionBlock {
                        _completionBlock(scannedResult)
                    }
                    
                    delegate?.reader(self, didScanResult: scannedResult)
                }
            }
        }
    }
}

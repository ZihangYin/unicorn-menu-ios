//
//  QRScannerViewController.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/24/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class QRCodeScannerViewController: UIViewController, QRCodeReaderDelegate {
    lazy var reader: QRCodeReaderViewController = QRCodeReaderViewController(cancelButtonTitle: "Cancel")
    let text = UILabel()
    let qrcode = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        self.text.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.text.userInteractionEnabled = true
        self.text.text = "Tap to scan QR code for the full menu"
        self.text.font = UIFont(name: "ProximaNova-Bold", size: 15)
        self.text.textAlignment = .Center
        self.text.textColor = UIColor.whiteColor()
        self.view.addSubview(text)
        
        self.qrcode.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.qrcode.text = "Last QR code"
        self.qrcode.font = UIFont(name: "ProximaNova-Bold", size: 12)
        self.qrcode.textAlignment = .Center
        self.qrcode.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width
        self.qrcode.numberOfLines = 10
        self.qrcode.lineBreakMode = .ByWordWrapping
        self.qrcode.textColor = UIColor.whiteColor()
        self.view.addSubview(qrcode)
        
        setupAutoLayoutConstraints()
        
        let scanAction = UITapGestureRecognizer.init(target: self, action: "scanAction:")
        self.text.addGestureRecognizer(scanAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scanAction(tap: UITapGestureRecognizer) {
        if (tap.state != .Ended) {
            return
        }

        reader.modalPresentationStyle = .FormSheet
        reader.delegate = self
        
        reader.completionBlock = { (result: String?) in
            self.qrcode.text = result
        }
        presentViewController(reader, animated: true, completion: nil)
    }
    
    func reader(reader: QRCodeReaderViewController, didScanResult result: String) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func setupAutoLayoutConstraints() {
        let views = ["text": self.text, "qrcode": self.qrcode]
        self.text.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[text(50)]", options: .allZeros, metrics: nil, views: views))
        self.qrcode.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[qrcode(50)]", options: .allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[text]-|", options: .allZeros, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[qrcode]-|", options: .allZeros, metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: self.text, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: -50))
        self.view.addConstraint(NSLayoutConstraint(item: self.qrcode, attribute: .CenterY, relatedBy: .Equal, toItem: self.text, attribute: .CenterY, multiplier: 1, constant: 50))
    }
}

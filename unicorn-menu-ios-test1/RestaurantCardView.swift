//
//  RestaurantCardView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 12/3/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class RestaurantCardView: UICollectionViewCell {
    
    var restaurantImages = [UIImage(named: "restaurant0.jpg")!, UIImage(named: "restaurant1.jpg")!]
    var slide = 0
    var restaurantImageView: UIImageView!
    var restaurantLogoView: UIImageView!
    var restaurantName: UILabel!
    var hourLabel: UILabel!
    var phoneLabel: UILabel!
    var addressLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.clipsToBounds = true;
        self.contentView.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        
        self.restaurantName = UILabel()
        self.restaurantName.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantName.text = "Restaurant Name"
        self.restaurantName.font = UIFont(name: "ProximaNova-Bold", size: 20)
        self.restaurantName.textAlignment = .Center
        self.restaurantName.textColor = UIColor.blackColor()
        self.contentView.addSubview(self.restaurantName)
        
        self.hourLabel = UILabel()
        self.hourLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.hourLabel.text = "Hours: 9am - 9pm"
        self.hourLabel.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.hourLabel.textAlignment = .Center
        self.hourLabel.textColor = UIColor.darkGrayColor()
        self.contentView.addSubview(self.hourLabel)
        
        self.phoneLabel = UILabel()
        self.phoneLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.phoneLabel.text = "Tel: 9196274749"
        self.phoneLabel.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.phoneLabel.textAlignment = .Center
        self.phoneLabel.textColor = UIColor.darkGrayColor()
        self.contentView.addSubview(self.phoneLabel)
        
        self.addressLabel = UILabel()
        self.addressLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addressLabel.text = "4535 12th Ave. NE, Seattle, WA 98101"
        self.addressLabel.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.addressLabel.textAlignment = .Center
        self.addressLabel.textColor = UIColor.darkGrayColor()
        self.contentView.addSubview(self.addressLabel)
        
        self.restaurantImageView = UIImageView()
        self.restaurantImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantImageView.contentMode = .ScaleAspectFill
        self.restaurantImageView.clipsToBounds = true
        self.contentView.addSubview(self.restaurantImageView)
        
        self.restaurantLogoView = UIImageView(image: UIImage(named: "logo.png"))
        self.restaurantLogoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.restaurantLogoView.clipsToBounds = true
        
        let logoLayer = self.restaurantLogoView.layer
        logoLayer.cornerRadius = 30
        logoLayer.borderWidth = 1
        logoLayer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).CGColor
        self.addSubview(self.restaurantLogoView)
        
        autoLayoutSubviews()
        
        self.changeSlide()
        
        // Loop gallery - fix loop: http://bynomial.com/blog/?p=67
        let timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("changeSlide"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    private func autoLayoutSubviews() {
        var viewsDictionary = ["restaurantImageView": self.restaurantImageView, "restaurantLogoView": self.restaurantLogoView, "restaurantName": self.restaurantName, "hourLabel": self.hourLabel,
            "phoneLabel": self.phoneLabel, "addressLabel": self.addressLabel]
        
        self.restaurantLogoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[restaurantLogoView(60)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.restaurantLogoView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[restaurantLogoView(60)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.restaurantImageView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[restaurantImageView(200)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[restaurantImageView]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-140-[restaurantImageView]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.restaurantName, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 1, constant: 0))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[restaurantName]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[restaurantName]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[hourLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.hourLabel, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 1, constant: 0))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-80-[hourLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.phoneLabel, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 1, constant: 0))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[phoneLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[phoneLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
//        self.contentView.addConstraint(NSLayoutConstraint(item: self.addressLabel, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 1, constant: 0))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[addressLabel]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-120-[addressLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.addConstraint(NSLayoutConstraint(item: self.restaurantLogoView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.restaurantLogoView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        
    }
    
    func changeSlide() {
        if (slide > restaurantImages.count - 1) {
            slide = 0
        }
        let toImage = restaurantImages[slide]
        UIView.transitionWithView(self.restaurantImageView, duration: 0.75, options: .TransitionCrossDissolve | .CurveEaseInOut, animations: {
            self.restaurantImageView.image = toImage
            },
            completion: nil)
        slide++;
    }
}

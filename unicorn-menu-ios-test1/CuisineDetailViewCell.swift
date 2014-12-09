//
//  RestaurantDetailViewCell.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/25/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

var BLUR_RADIUS: CGFloat = 14
var BLUR_TINT_COLOR = UIColor(white: 0, alpha: 0.3)
var BLUR_DELTA_FACTOR: CGFloat = 1.4
var MAX_BACKGROUND_MOVEMENT_VERTICAL: CGFloat = 30
var MAX_BACKGROUND_MOVEMENT_HORIZONTAL: CGFloat = 20

class CuisineDetailViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var cuisineNameLabel: UILabel!
    var cuisineLikesLogo: UIImageView!
    var cuisineLikesLabel: UILabel!
    var cuisinePriceLabel: UILabel!
    var cuisineDescriptionLabel: UILabel!
    
    var backgroundImageView: UIImageView!
    var blurredBackgroundImageView: UIImageView!
    private var cuisineView: UIView!
    private var cuisineBackgroundBox: UIView!
    
    private var foregroundView: UIView!
    private var foregroundScrollView: UIScrollView!
    private var foregroundContainerView: UIView!
    private var bottomShadowLayer: CALayer!
    private var backgroundScrollView: UIScrollView!
    private var backgroundConstraintView: UIView!
    private var bottomDistance: CGFloat?
    
    private var spacerConstraint : [AnyObject]? {
        didSet {
            if oldValue != nil {
                foregroundScrollView.removeConstraints(oldValue!)
            }
            if spacerConstraint != nil {
                self.foregroundScrollView.addConstraints(spacerConstraint!)
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundScrollView = UIScrollView(frame: self.contentView.frame)
        backgroundScrollView.userInteractionEnabled = false
        backgroundScrollView.contentSize = CGSizeMake(self.contentView.frame.size.width + 2 * MAX_BACKGROUND_MOVEMENT_HORIZONTAL, self.contentView.frame.size.height + MAX_BACKGROUND_MOVEMENT_VERTICAL)
        backgroundScrollView.setContentOffset(CGPointMake(MAX_BACKGROUND_MOVEMENT_HORIZONTAL, 0), animated: false)
        self.contentView.addSubview(backgroundScrollView)
        
        backgroundConstraintView = UIView(frame: CGRectMake(0, 0, self.backgroundScrollView.contentSize.width, self.backgroundScrollView.contentSize.height))
        self.backgroundScrollView.addSubview(backgroundConstraintView)
        
        backgroundImageView = UIImageView()
        backgroundImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        backgroundImageView.contentMode = .ScaleAspectFill
        self.backgroundConstraintView.addSubview((backgroundImageView))
        
        blurredBackgroundImageView = UIImageView()
        blurredBackgroundImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurredBackgroundImageView.contentMode = .ScaleAspectFill
        blurredBackgroundImageView.alpha = 0
        self.backgroundConstraintView.addSubview(blurredBackgroundImageView)
        
        autoLayoutBackgroundSubviews()
        
        self.foregroundContainerView = UIView(frame: self.contentView.frame)
        self.contentView.addSubview(foregroundContainerView)

        self.foregroundScrollView = UIScrollView(frame: self.contentView.frame)
        self.foregroundScrollView.delegate = self
        self.foregroundScrollView.showsVerticalScrollIndicator = false
        self.foregroundScrollView.showsHorizontalScrollIndicator = false
        self.foregroundContainerView.addSubview(foregroundScrollView)

        self.foregroundView = UIView()
        self.foregroundView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.foregroundScrollView.addSubview(foregroundView)
        addForegroundSubviews()
        autoLayoutForegroundSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        spacerConstraint = nil
    }
    
    func setCuisineName(text: String) {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .ByWordWrapping
        let cuisineNameBoundingSize = text.boundingRectWithSize(CGSizeMake(self.contentView.frame.width * 0.7, CGFloat.max), options: .UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UIFont(name: "ProximaNova-Bold", size:24)!, NSParagraphStyleAttributeName: paraStyle], context: nil)
        self.bottomDistance = ceil(cuisineNameBoundingSize.height) + 20
        let topMargin = self.contentView.frame.size.height - self.bottomDistance!
        spacerConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-topMargin-[foregroundView]-0-|", options: NSLayoutFormatOptions(0), metrics: ["topMargin": topMargin], views: ["foregroundView" :self.foregroundView])
        self.cuisineNameLabel.text = text
//        
//        bottomShadowLayer?.removeFromSuperlayer()
//        bottomShadowLayer = self.createTopMaskWithSize(CGSizeMake(self.contentView.frame.size.width, bootmDistance), startFadeAt: 0, endAt: bootmDistance, topColor: UIColor(white: 0, alpha: 0.0), botColor: UIColor(white: 0, alpha: 0.5))
//        bottomShadowLayer.frame = CGRectOffset((bottomShadowLayer.bounds), 0, self.contentView.frame.size.height - bootmDistance)
//        self.layer.insertSublayer(bottomShadowLayer, below: foregroundContainerView.layer)
    }
    
    func scrollVerticallyToOffset(offsetY: CGFloat){
        self.foregroundScrollView.setContentOffset(CGPointMake(self.foregroundScrollView.contentOffset.x, offsetY), animated: false)
    }
    
    func scrollHorizontalRatio(ratio: CGFloat){
        self.backgroundScrollView.setContentOffset(CGPointMake(MAX_BACKGROUND_MOVEMENT_HORIZONTAL + ratio * MAX_BACKGROUND_MOVEMENT_HORIZONTAL, self.backgroundScrollView.contentOffset.y), animated: false)
    }

    private func addForegroundSubviews() {
        cuisineNameLabel = UILabel()
        cuisineNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisineNameLabel.font = UIFont(name: "ProximaNova-Bold", size: 24)
        cuisineNameLabel.textAlignment = .Left
        cuisineNameLabel.numberOfLines = 10
        cuisineNameLabel.lineBreakMode = .ByWordWrapping
        cuisineNameLabel.textColor = UIColor.whiteColor()
        cuisineNameLabel.shadowColor = UIColor.blackColor()
        cuisineNameLabel.shadowOffset = CGSizeMake(1, 1)
        
        cuisineLikesLogo  = UIImageView(image: UIImage(named: "heart.png"))
        cuisineLikesLogo.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisineLikesLogo.clipsToBounds = true
        
        cuisineLikesLabel = UILabel()
        cuisineLikesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisineLikesLabel.font = UIFont(name: "ProximaNova-Light", size: 18)
        cuisineLikesLabel.numberOfLines = 1
        cuisineLikesLabel.textAlignment = .Center
        cuisineLikesLabel.textColor = UIColor.whiteColor()
        cuisineLikesLabel.shadowColor = UIColor.blackColor()
        cuisineLikesLabel.shadowOffset = CGSizeMake(1, 1)
        
        cuisineView = UIView()
        cuisineView.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisineView.addSubview(cuisineNameLabel)
        cuisineView.addSubview(cuisineLikesLogo)
        cuisineView.addSubview(cuisineLikesLabel)
        
        cuisineBackgroundBox = UIView()
        cuisineBackgroundBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisineBackgroundBox.layer.cornerRadius = 3;
        cuisineBackgroundBox.backgroundColor = UIColor(white: 0, alpha: 0.15)
        
        cuisinePriceLabel = UILabel()
        cuisinePriceLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisinePriceLabel.font = UIFont(name: "ProximaNova-Light", size: 22)
        cuisinePriceLabel.textAlignment = .Left
        cuisinePriceLabel.numberOfLines = 1
        cuisinePriceLabel.textColor = UIColor.whiteColor()
        
        cuisineDescriptionLabel = UILabel()
        cuisineDescriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        cuisineDescriptionLabel.font = UIFont(name: "ProximaNova-Regualr", size: 20)
        cuisineDescriptionLabel.textAlignment = .Left
        cuisineDescriptionLabel.numberOfLines = 50
        cuisineDescriptionLabel.lineBreakMode = .ByWordWrapping
        cuisineDescriptionLabel.textColor = UIColor.whiteColor()
        
        self.cuisineBackgroundBox.addSubview(cuisinePriceLabel)
        self.cuisineBackgroundBox.addSubview(cuisineDescriptionLabel)
        
        self.foregroundView.addSubview(cuisineView)
        self.foregroundView.addSubview(cuisineBackgroundBox)
    }
    
    private func autoLayoutForegroundSubviews() {
        var viewsDictionary = ["cuisineName": cuisineNameLabel, "cuisineDescription": cuisineDescriptionLabel, "cuisineLikesLogo": cuisineLikesLogo, "cuisineLikesLabel": cuisineLikesLabel, "cuisinePriceLabel": cuisinePriceLabel,
            "cuisineView": cuisineView, "cuisineBackgroundBox": cuisineBackgroundBox, "foregroundScrollView": self.foregroundScrollView, "foregroundView": self.foregroundView]
        
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cuisineLikesLogo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineLikesLogo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[cuisineLikesLogo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.cuisineView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[cuisineName]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cuisineLikesLogo]-0-[cuisineLikesLabel]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineView.addConstraint(NSLayoutConstraint(item: cuisineNameLabel, attribute: .Width, relatedBy: .Equal, toItem: cuisineView, attribute: .Width, multiplier: 0.7, constant: 1))
        
        self.cuisineView.addConstraint(NSLayoutConstraint(item: cuisineLikesLogo, attribute: .Bottom, relatedBy: .Equal, toItem: cuisineView, attribute: .Bottom, multiplier: 1, constant: 0))
        self.cuisineView.addConstraint(NSLayoutConstraint(item: cuisineLikesLabel, attribute: .Bottom, relatedBy: .Equal, toItem: cuisineView, attribute: .Bottom, multiplier: 1, constant: 0))
        self.cuisineView.addConstraint(NSLayoutConstraint(item: cuisineNameLabel, attribute: .CenterY, relatedBy: .Equal, toItem: cuisineView, attribute: .CenterY, multiplier: 1, constant: 0))
        
        self.cuisineView.addConstraint(NSLayoutConstraint(item: cuisineView, attribute: .Height, relatedBy: .Equal, toItem: cuisineNameLabel, attribute: .Height, multiplier: 1, constant: 0))
        
        self.cuisineBackgroundBox.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[cuisinePriceLabel]-15-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineBackgroundBox.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[cuisineDescription]-15-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.cuisineBackgroundBox.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[cuisinePriceLabel]-10-[cuisineDescription]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.foregroundView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cuisineView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.foregroundView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[cuisineBackgroundBox]-5-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.foregroundView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[cuisineView]-10-[cuisineBackgroundBox]-10-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.foregroundScrollView.addConstraint(NSLayoutConstraint(item: self.foregroundScrollView, attribute: .Width, relatedBy: .Equal, toItem: self.foregroundView, attribute: .Width, multiplier: 1, constant: 0))
        self.foregroundScrollView.addConstraint(NSLayoutConstraint(item: self.foregroundScrollView, attribute: .CenterX, relatedBy: .Equal, toItem: self.foregroundView, attribute: .CenterX, multiplier: 1, constant: 0))
    }
    
    private func  autoLayoutBackgroundSubviews() {
        self.backgroundConstraintView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[bgImageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["bgImageView":backgroundImageView]))
        self.backgroundConstraintView.addConstraints((NSLayoutConstraint.constraintsWithVisualFormat("H:|[bgImageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["bgImageView":backgroundImageView])))
        self.backgroundConstraintView.addConstraints((NSLayoutConstraint.constraintsWithVisualFormat("V:|[blurredBgImageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["blurredBgImageView":blurredBackgroundImageView])))
        self.backgroundConstraintView.addConstraints((NSLayoutConstraint.constraintsWithVisualFormat("H:|[blurredBgImageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["blurredBgImageView":blurredBackgroundImageView])))
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        let height = min(foregroundScrollView.frame.size.height, foregroundView.frame.size.height)
        var ratio = (scrollView.contentOffset.y + foregroundScrollView.contentInset.top)/(height - foregroundScrollView.contentInset.top - self.bottomDistance!)
        ratio = ratio < 0 ? 0 : ratio
        ratio = ratio > 1 ? 1 : ratio
        
        backgroundScrollView.setContentOffset(CGPointMake(MAX_BACKGROUND_MOVEMENT_HORIZONTAL, ratio * MAX_BACKGROUND_MOVEMENT_VERTICAL), animated: false)
        blurredBackgroundImageView.alpha = ratio
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView!, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let point: CGPoint = targetContentOffset.memory
        var ratio = (point.y + foregroundScrollView.contentInset.top)/(foregroundScrollView.frame.size.height - foregroundScrollView.contentInset.top - self.bottomDistance!)
        
        if ratio > 0 && ratio < 1 {
            if velocity.y == 0 {
                ratio = ratio > 0.5 ? 1 : 0
            } else if velocity.y > 0 {
                ratio = ratio > 0.1 ? 1 : 0
            } else {
                ratio = ratio > 0.9 ? 1 : 0
            }
        }
        targetContentOffset.memory.y = ratio * foregroundView.frame.origin.y - foregroundScrollView.contentInset.top
    }
    
    private func createTopMaskWithSize(size: CGSize, startFadeAt: CGFloat, endAt: CGFloat, topColor: UIColor, botColor: UIColor) -> CALayer {
        let top = startFadeAt/size.height;
        let bottom = endAt/size.height;
        
        var maskLayer = CAGradientLayer()
        maskLayer.anchorPoint = CGPointZero;
        maskLayer.startPoint = CGPointMake(0.5, 0.0);
        maskLayer.endPoint = CGPointMake(0.5, 1.0);
        
        let colors: [AnyObject] = [topColor.CGColor, topColor.CGColor, botColor.CGColor, botColor.CGColor]
        maskLayer.colors = colors
        maskLayer.locations = [0.0, top, bottom, 1.0]
        maskLayer.frame = CGRectMake(0, 0, size.width, size.height);
        
        return maskLayer;
    }
}



//
//  CuisineDetailView.swift
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

var TOP_FADING_HEIGHT_HALF: CGFloat = 10

@objc protocol BlurScrollViewDelegate
{
    optional func blurScrollView(blurScrollView: CuisineDetailView, didChangedToFrame: CGRect)
}

class CuisineDetailView: UIView, UIScrollViewDelegate {
    
    var _backgroundImage: UIImage! {
        didSet {
            self.setBackgroundImage(_backgroundImage)
        }
    }
    
    var _foregroundView: UIView! {
        didSet {
            self.constructForegroundView()
            self.constructBottomShadow()
        }
    }
    
    var _viewDistanceFromBottom: CGFloat = 60 {
        didSet {
            self.setViewDistanceFromBottom()
        }
    }
    
    var _blurredBackgroundImage: UIImage!
    var _topLayoutGuideLength: UIView!
    var _foregroundScrollView: UIScrollView!
    var delegate: BlurScrollViewDelegate?
    override var frame: CGRect {
        set {
            self.setFrame(newValue)
        }
        get {
            return super.frame
        }
    }
    private var _backgroundScrollView: UIScrollView!
    private var _constraintView: UIView!
    private var _backgroundImageView: UIImageView!
    private var _blurredBackgroundImageView: UIImageView!
    private var _topShadowLayer: CALayer!
    private var _bottomShadowLayer: CALayer!
    private var _foregroundContainerView: UIView!
    private var _topMaskImageView: UIImageView!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, backgroundImage: UIImage, blurredImage: UIImage?, viewDistanceFromBottom: CGFloat, foregroundView: UIView) {
        super.init(frame: frame)
        _backgroundImage = backgroundImage
        if let blurImg = blurredImage {
            _blurredBackgroundImage = backgroundImage
        } else {
            _blurredBackgroundImage = backgroundImage.applyBlurWithRadius(BLUR_RADIUS, tintColor: BLUR_TINT_COLOR, saturationDeltaFactor: BLUR_DELTA_FACTOR, maskImage: nil)
        }
        _viewDistanceFromBottom = viewDistanceFromBottom
        _foregroundView = foregroundView
        
        self.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        self.constructBackgroundView()
        self.constructBackgroundImageView()
        self.constructForegroundView()
        self.constructBottomShadow()
        self.constructTopShadow()

    }
    
    func setBackgroundImage(image: UIImage) {
        _blurredBackgroundImage = _backgroundImage.applyBlurWithRadius(BLUR_RADIUS, tintColor: BLUR_TINT_COLOR, saturationDeltaFactor: BLUR_DELTA_FACTOR, maskImage: nil)
        self.constructBackgroundView()
        self.constructBackgroundImageView()
    }
    
    func scrollHorizontalRatio(ratio: CGFloat){
        _backgroundScrollView.setContentOffset(CGPointMake(MAX_BACKGROUND_MOVEMENT_HORIZONTAL + ratio * MAX_BACKGROUND_MOVEMENT_HORIZONTAL, _backgroundScrollView.contentOffset.y), animated: false)
    }
    
    func scrollVerticallyToOffset(offsetY: CGFloat){
        _foregroundScrollView.setContentOffset(CGPointMake(_foregroundScrollView.contentOffset.x, offsetY), animated: false)
    }
    
    func setTopLayoutGuideLength(topLayoutGuideLength:CGFloat){
        if topLayoutGuideLength == 0 {
            return
        }
        _foregroundScrollView.contentInset = UIEdgeInsetsMake(topLayoutGuideLength, 0, 0, 0)
        _foregroundView.frame = CGRectOffset(_foregroundView.bounds, (_foregroundScrollView.frame.size.width - _foregroundView.bounds.size.width)/2, _foregroundScrollView.frame.size.height - _foregroundScrollView.contentInset.top - _viewDistanceFromBottom)
        _foregroundScrollView.contentSize = CGSizeMake(self.frame.size.width, -_foregroundView.frame.origin.y + _foregroundView.frame.size.height)
        
        _foregroundScrollView.setContentOffset(CGPointMake(0, -_foregroundScrollView.contentInset.top), animated: false)
        
        _foregroundContainerView.layer.mask = self.createTopMaskWithSize(CGSizeMake(_foregroundContainerView.frame.size.width, _foregroundContainerView.frame.size.height), startFadeAt: _foregroundScrollView.contentInset.top - TOP_FADING_HEIGHT_HALF, endAt: _foregroundScrollView.contentInset.top + TOP_FADING_HEIGHT_HALF, topColor: UIColor(white: 1.0, alpha: 0.0), botColor: UIColor(white: 1.0, alpha: 1.0))
        self.constructTopShadow()
    }
    
    func constructBackgroundImage(image: UIImage, overWriteBlur:Bool, animated: Bool, duration: NSTimeInterval) {
        _backgroundImage = image
        if overWriteBlur {
            _blurredBackgroundImage = image.applyBlurWithRadius(BLUR_RADIUS, tintColor: BLUR_TINT_COLOR, saturationDeltaFactor: BLUR_DELTA_FACTOR, maskImage: nil)
        }
        
        if (animated) {
            let previousBackgroundImageView = _backgroundImageView
            let previousBlurredBackgroundImageView = _blurredBackgroundImageView
            self.constructBackgroundImageView()
            
            _backgroundImageView.alpha = 0
            _blurredBackgroundImageView.alpha = 0
            
            // blur needs to get animated first if the background is blurred
            if (previousBlurredBackgroundImageView.alpha == 1) {
                
                UIView.animateWithDuration(duration, animations: {
                    self._blurredBackgroundImageView.alpha = previousBlurredBackgroundImageView.alpha
                    }, completion:{(Bool) in
                        self._backgroundImageView.alpha = previousBackgroundImageView.alpha
                        previousBackgroundImageView.removeFromSuperview()
                        previousBlurredBackgroundImageView.removeFromSuperview()
                })
            } else {
                UIView.animateWithDuration(duration, animations: {
                    self._backgroundImageView.alpha = previousBackgroundImageView.alpha
                    self._blurredBackgroundImageView.alpha = previousBlurredBackgroundImageView.alpha
                    }, completion:{(Bool) in
                        previousBackgroundImageView.removeFromSuperview()
                        previousBlurredBackgroundImageView.removeFromSuperview()
                })
            }
        } else {
            _backgroundImageView.image = image
            _blurredBackgroundImageView.image = _blurredBackgroundImage
            
        }
        
        _backgroundImageView.setNeedsDisplay()
        _blurredBackgroundImageView.setNeedsDisplay()
    }
    
    func shouldBlurBackground(shouldBlur: Bool) {
        _blurredBackgroundImageView.alpha = shouldBlur ? 1 : 0
    }
    
    func constructBackgroundView() {
        _backgroundScrollView = UIScrollView(frame: self.frame)
        _backgroundScrollView.userInteractionEnabled = false
        _backgroundScrollView.contentSize = CGSizeMake(self.frame.size.width + 2 * MAX_BACKGROUND_MOVEMENT_HORIZONTAL, self.frame.size.height + MAX_BACKGROUND_MOVEMENT_VERTICAL)
        // DIFF
        _backgroundScrollView.setContentOffset(CGPointMake(MAX_BACKGROUND_MOVEMENT_HORIZONTAL, 0), animated: false)
        
        _backgroundScrollView.backgroundColor = UIColor.greenColor()
        self.addSubview(_backgroundScrollView)
        
        _constraintView = UIView(frame: CGRectMake(0, 0, self.frame.size.width + 2 * MAX_BACKGROUND_MOVEMENT_HORIZONTAL, self.frame.size.height + MAX_BACKGROUND_MOVEMENT_VERTICAL))
        _backgroundScrollView.addSubview(_constraintView)
        
    }
    
    func constructBackgroundImageView() {
        _constraintView.backgroundColor = UIColor.redColor()
        
        _backgroundImageView = UIImageView(image: _backgroundImage)
        _backgroundImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        _backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        _constraintView.addSubview((_backgroundImageView))
        
        _blurredBackgroundImageView = UIImageView(image: _blurredBackgroundImage)
        _blurredBackgroundImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        _blurredBackgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        _blurredBackgroundImageView.alpha = 0
        _constraintView.addSubview(_blurredBackgroundImageView)
        
        _constraintView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[bgImageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["bgImageView":_backgroundImageView]))
        _constraintView.addConstraints((NSLayoutConstraint.constraintsWithVisualFormat("H:|[bgImageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["bgImageView":_backgroundImageView])))
        _constraintView.addConstraints((NSLayoutConstraint.constraintsWithVisualFormat("V:|[blurredBgImageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["blurredBgImageView":_blurredBackgroundImageView])))
        _constraintView.addConstraints((NSLayoutConstraint.constraintsWithVisualFormat("H:|[blurredBgImageView]|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["blurredBgImageView":_blurredBackgroundImageView])))
    }
    
    func constructForegroundView() {
        _foregroundContainerView = UIView(frame: self.frame)
        self.addSubview(_foregroundContainerView)
        
        _foregroundScrollView = UIScrollView(frame: self.frame)
        _foregroundScrollView.delegate = self
        _foregroundScrollView.showsVerticalScrollIndicator = false
        _foregroundScrollView.showsHorizontalScrollIndicator = false
        _foregroundContainerView.addSubview(_foregroundScrollView)
        
//        
//        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: "foregroundTapped:")
//        _foregroundScrollView.addGestureRecognizer(tapRecognizer)
        
        _foregroundView.frame = CGRectOffset(_foregroundView.bounds, (_foregroundScrollView.frame.size.width - _foregroundView.bounds.size.width)/2, _foregroundScrollView.frame.size.height - _viewDistanceFromBottom)
        _foregroundScrollView.addSubview(_foregroundView)
        _foregroundScrollView.contentSize = CGSizeMake(self.frame.size.width, _foregroundView.frame.origin.y + _foregroundView.frame.size.height)
    }
    
    func createTopMaskWithSize(size: CGSize, startFadeAt: CGFloat, endAt: CGFloat, topColor: UIColor, botColor: UIColor) -> CALayer {
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
    
    func constructTopShadow(){
        _topShadowLayer?.removeFromSuperlayer()
        _topShadowLayer = self.createTopMaskWithSize(CGSizeMake(_foregroundContainerView.frame.size.width, _foregroundScrollView.contentInset.top + TOP_FADING_HEIGHT_HALF), startFadeAt: _foregroundScrollView.contentInset.top - TOP_FADING_HEIGHT_HALF, endAt: _foregroundScrollView.contentInset.top + TOP_FADING_HEIGHT_HALF, topColor: UIColor(white: 0, alpha: 0.15), botColor: UIColor(white: 0, alpha: 0))
        self.layer.insertSublayer(_topShadowLayer, above: _foregroundContainerView.layer)
    }
    
    func constructBottomShadow(){
        _bottomShadowLayer?.removeFromSuperlayer()
        _bottomShadowLayer = self.createTopMaskWithSize(CGSizeMake(self.frame.size.width, _viewDistanceFromBottom), startFadeAt: 0, endAt: _viewDistanceFromBottom, topColor: UIColor(white: 0, alpha: 0.0), botColor: UIColor(white: 0, alpha: 0.8))
        _bottomShadowLayer.frame = CGRectOffset((_bottomShadowLayer.bounds), 0, self.frame.size.height - _viewDistanceFromBottom)
        self.layer.insertSublayer(_bottomShadowLayer, below: _foregroundContainerView.layer)
    }
    
    func setViewDistanceFromBottom(){
        _foregroundView.frame = CGRectOffset(_foregroundView.bounds, (_foregroundScrollView.frame.size.width - _foregroundView.bounds.size.width)/2, _foregroundScrollView.frame.size.height - _foregroundScrollView.contentInset.top - _viewDistanceFromBottom)
        _foregroundScrollView.contentSize = CGSizeMake(self.frame.size.width, _foregroundView.frame.origin.y + _foregroundView.frame.size.height)
        
        _bottomShadowLayer.frame = CGRectOffset(_bottomShadowLayer.bounds, 0, self.frame.size.height - _viewDistanceFromBottom)
    }
    
    func setFrame(frame:CGRect){
        super.frame = frame;
        let bound = CGRectOffset(frame, -frame.origin.x, -frame.origin.y)
        
        _backgroundScrollView?.frame = bound
        _backgroundScrollView?.contentSize = CGSizeMake(bound.size.width + 2 * MAX_BACKGROUND_MOVEMENT_HORIZONTAL, bound.size.height + MAX_BACKGROUND_MOVEMENT_VERTICAL);
        _backgroundScrollView?.setContentOffset(CGPointMake(MAX_BACKGROUND_MOVEMENT_HORIZONTAL, 0), animated: false)
        
        _constraintView?.frame = CGRectMake(0, 0, frame.size.width + 2 * MAX_BACKGROUND_MOVEMENT_HORIZONTAL, frame.size.height + MAX_BACKGROUND_MOVEMENT_VERTICAL)
        
        //foreground
        _foregroundContainerView?.frame = bound
        _foregroundScrollView?.frame = bound
        if let fgv = _foregroundView {
            _foregroundView?.frame = CGRectOffset(_foregroundView.bounds, (_foregroundScrollView.frame.size.width - _foregroundView.bounds.size.width)/2,
                _foregroundScrollView.frame.size.height - _foregroundScrollView.contentInset.top - _viewDistanceFromBottom)
        }
        
        if let fgs = _foregroundScrollView {
            _foregroundScrollView?.contentSize = CGSizeMake(bound.size.width, _foregroundView.frame.origin.y + _foregroundView.frame.size.height)
            // DIFF
            _topShadowLayer?.frame = CGRectMake(0, 0, frame.size.width, _foregroundScrollView.contentInset.top + TOP_FADING_HEIGHT_HALF)
            _bottomShadowLayer?.frame = CGRectMake(0, bound.size.height - _viewDistanceFromBottom, bound.size.width, bound.size.height)
        }
        
        delegate?.blurScrollView!(self, didChangedToFrame: bound)
    }

    func scrollViewDidScroll(scrollView: UIScrollView!) {
        let height = min(_foregroundScrollView.frame.size.height, _foregroundView.frame.size.height)
        
        var ratio = (scrollView.contentOffset.y + _foregroundScrollView.contentInset.top)/(height - _foregroundScrollView.contentInset.top - _viewDistanceFromBottom)
        ratio = ratio < 0 ? 0 : ratio
        ratio = ratio > 1 ? 1 : ratio
        
        _backgroundScrollView.setContentOffset(CGPointMake(MAX_BACKGROUND_MOVEMENT_HORIZONTAL, ratio * MAX_BACKGROUND_MOVEMENT_VERTICAL), animated: false)
        _blurredBackgroundImageView.alpha = ratio
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView!, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let point: CGPoint = targetContentOffset.memory
        var ratio = (point.y + _foregroundScrollView.contentInset.top)/(_foregroundScrollView.frame.size.height - _foregroundScrollView.contentInset.top - _viewDistanceFromBottom)
        
        if ratio > 0 && ratio < 1 {
            if velocity.y == 0 {
                ratio = ratio > 0.5 ? 1 : 0
            } else if velocity.y > 0 {
                ratio = ratio > 0.1 ? 1 : 0
            } else {
                ratio = ratio > 0.9 ? 1 : 0
            }
        }
        targetContentOffset.memory.y = ratio * _foregroundView.frame.origin.y - _foregroundScrollView.contentInset.top
    }
}

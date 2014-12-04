//
//  FilterView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/23/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class FilterView: UIView {

    var btnOne : UIButton!
    var btnArrowOne : UIButton!
    var btnTwo : UIButton!
    var btnArrowTwo : UIButton!
    var btnThree : UIButton!
    var btnFour : UIButton!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        
        var labelOne = UILabel()
        labelOne.setTranslatesAutoresizingMaskIntoConstraints(false)
        labelOne.text = "I'm craving for"
        labelOne.textAlignment = NSTextAlignment.Center
        labelOne.font = UIFont(name: "ProximaNova-Regular", size: 16)
        labelOne.textColor = UIColor.blackColor()
        self.addSubview(labelOne)
        
        self.btnOne = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        btnOne!.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnOne!.setTitle("Anything", forState: UIControlState.Normal)
        btnOne!.backgroundColor = UIColor.whiteColor()
        btnOne!.tintColor = UIColor.redColor()
        btnOne!.titleLabel!.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.addSubview(btnOne!)
        
        self.btnArrowOne = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btnArrowOne.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnArrowOne.setImage(UIImage(named: "right_red.png"), forState: UIControlState.Normal)
        self.addSubview(btnArrowOne)
        
        var labelTwo = UILabel()
        labelTwo.setTranslatesAutoresizingMaskIntoConstraints(false)
        labelTwo.text = "for"
        labelTwo.textAlignment = NSTextAlignment.Center
        labelTwo.font = UIFont(name: "ProximaNova-Regular", size: 16)
        labelTwo.textColor = UIColor.blackColor()
        self.addSubview(labelTwo)
        
        self.btnTwo = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        btnTwo!.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnTwo!.setTitle("Dinner", forState: UIControlState.Normal)
        btnTwo!.backgroundColor = UIColor.whiteColor()
        btnTwo!.tintColor = UIColor.redColor()
        btnTwo!.titleLabel!.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.addSubview(btnTwo!)
        
        self.btnArrowTwo = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btnArrowTwo.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnArrowTwo.setImage(UIImage(named: "right_red.png"), forState: UIControlState.Normal)
        self.addSubview(btnArrowTwo)
        
        self.btnThree = UIButton.buttonWithType(UIButtonType.System) as UIButton
        btnThree.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnThree.setTitle("Cancel", forState: UIControlState.Normal)
        btnThree.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        btnThree.tintColor = UIColor.whiteColor()
        btnThree.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.addSubview(btnThree)
        
        self.btnFour = UIButton.buttonWithType(UIButtonType.System) as UIButton
        btnFour.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnFour.setTitle("OK", forState: UIControlState.Normal)
        btnFour.backgroundColor = UIColor.redColor()
        btnFour.tintColor = UIColor.whiteColor()
        btnFour.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 16)
        self.addSubview(btnFour)
        
        var viewsDictionary = ["labelOne": labelOne, "labelTwo": labelTwo, "btnOne": self.btnOne!, "btnArrowOne": self.btnArrowOne,
            "btnTwo": self.btnTwo!, "btnArrowTwo": self.btnArrowTwo, "btnThree": self.btnThree, "btnFour": self.btnFour]
 
        self.btnArrowOne.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[btnArrowOne(64)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.btnArrowOne.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[btnArrowOne(64)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.btnArrowTwo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[btnArrowTwo(64)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.btnArrowTwo.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[btnArrowTwo(64)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.btnOne!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[btnOne(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.btnTwo!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[btnTwo(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.btnThree.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[btnThree(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.btnFour.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[btnFour(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[labelOne]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[labelTwo]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[btnOne]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[btnTwo]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-40-[labelOne]-10-[btnOne]-50-[labelTwo]-10-[btnTwo]",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraint(NSLayoutConstraint(item: btnArrowOne, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 15))
        self.addConstraint(NSLayoutConstraint(item: btnArrowTwo, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 15))
        self.addConstraint(NSLayoutConstraint(item: btnArrowOne, attribute: .CenterY, relatedBy: .Equal, toItem: btnOne, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: btnArrowTwo, attribute: .CenterY, relatedBy: .Equal, toItem: btnTwo, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: btnFour, attribute: .Width, relatedBy: .Equal, toItem: btnThree, attribute: .Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: btnFour, attribute: .CenterY, relatedBy: .Equal, toItem: btnThree, attribute: .CenterY, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[btnThree]-20-[btnFour]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[btnThree]-30-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }
}

//
//  FilterView.swift
//  unicorn-menu-ios-test1
//
//  Created by Zihang Yin on 11/23/14.
//  Copyright (c) 2014 Unicorn. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    var blackView : UIView!
    var clearView : UIView!
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
        
        self.blackView = UIView(frame: self.frame)
        blackView.backgroundColor = UIColor.darkGrayColor()
        self.addSubview(blackView)
        
        self.clearView = UIView(frame: self.frame)
        self.clearView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        self.addSubview(clearView)
        
        var labelOne = UILabel()
        labelOne.setTranslatesAutoresizingMaskIntoConstraints(false)
        labelOne.text = "I'm craving for"
        labelOne.textAlignment = NSTextAlignment.Center
        labelOne.font = UIFont(name: "ProximaNova-Regular", size: 20)
        labelOne.textColor = UIColor.whiteColor()
        clearView.addSubview(labelOne)
        
        self.btnOne = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        btnOne!.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnOne!.setTitle("Anything", forState: UIControlState.Normal)
        btnOne!.tintColor = UIColor.whiteColor()
        btnOne!.titleLabel!.font = UIFont(name: "ProximaNova-Regular", size: 20)
        clearView.addSubview(btnOne!)
        
        let topBorderForBtnOne = UIView()
        topBorderForBtnOne.setTranslatesAutoresizingMaskIntoConstraints(false)
        topBorderForBtnOne.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        clearView.addSubview(topBorderForBtnOne)
        
        let bottomBorderForBtnOne = UIView()
        bottomBorderForBtnOne.setTranslatesAutoresizingMaskIntoConstraints(false)
        bottomBorderForBtnOne.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        clearView.addSubview(bottomBorderForBtnOne)
        
        self.btnArrowOne = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btnArrowOne.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnArrowOne.setImage(UIImage(named: "right_big.png"), forState: UIControlState.Normal)
        clearView.addSubview(btnArrowOne)
        
        var labelTwo = UILabel()
        labelTwo.setTranslatesAutoresizingMaskIntoConstraints(false)
        labelTwo.text = "for"
        labelTwo.textAlignment = NSTextAlignment.Center
        labelTwo.font = UIFont(name: "ProximaNova-Regular", size: 20)
        labelTwo.textColor = UIColor.whiteColor()
        clearView.addSubview(labelTwo)
        
        self.btnTwo = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        btnTwo!.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnTwo!.setTitle("Dinner", forState: UIControlState.Normal)
        btnTwo!.tintColor = UIColor.whiteColor()
        btnTwo!.titleLabel!.font = UIFont(name: "ProximaNova-Regular", size: 20)
        clearView.addSubview(btnTwo!)
        
        let topBorderForBtnTwo = UIView()
        topBorderForBtnTwo.setTranslatesAutoresizingMaskIntoConstraints(false)
        topBorderForBtnTwo.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        clearView.addSubview(topBorderForBtnTwo)
        
        let bottomBorderForBtnTwo = UIView()
        bottomBorderForBtnTwo.setTranslatesAutoresizingMaskIntoConstraints(false)
        bottomBorderForBtnTwo.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        clearView.addSubview(bottomBorderForBtnTwo)
        
        self.btnArrowTwo = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btnArrowTwo.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnArrowTwo.setImage(UIImage(named: "right_big.png"), forState: UIControlState.Normal)
        clearView.addSubview(btnArrowTwo)
        
        self.btnThree = UIButton.buttonWithType(UIButtonType.System) as UIButton
        btnThree.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnThree.setTitle("Cancel", forState: UIControlState.Normal)
        btnThree.tintColor = UIColor.whiteColor()
        btnThree.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 20)
        btnThree.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).CGColor
        btnThree.layer.borderWidth = 0.5
        clearView.addSubview(btnThree)
        
        self.btnFour = UIButton.buttonWithType(UIButtonType.System) as UIButton
        btnFour.setTranslatesAutoresizingMaskIntoConstraints(false)
        btnFour.setTitle("OK", forState: UIControlState.Normal)
        btnFour.tintColor = UIColor.whiteColor()
        btnFour.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 20)
        btnFour.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).CGColor
        btnFour.layer.borderWidth = 0.5
        clearView.addSubview(btnFour)
        
        var viewsDictionary = ["labelOne": labelOne, "labelTwo": labelTwo, "btnOne": self.btnOne!, "btnArrowOne": self.btnArrowOne, "topBorderForBtnOne": topBorderForBtnOne, "bottomBorderForBtnOne": bottomBorderForBtnOne,
            "btnTwo": self.btnTwo!, "btnArrowTwo": self.btnArrowTwo, "topBorderForBtnTwo": topBorderForBtnTwo, "bottomBorderForBtnTwo": bottomBorderForBtnTwo, "btnThree": self.btnThree, "btnFour": self.btnFour]
        
        let topBorderForBtnOne_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[topBorderForBtnOne(0.5)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let bottomBorderForBtnOne_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomBorderForBtnOne(0.5)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let topBorderForBtnTwo_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[topBorderForBtnTwo(0.5)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let bottomBorderForBtnTwo_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomBorderForBtnTwo(0.5)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnArrowOne_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[btnArrowOne(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnArrowOne_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[btnArrowOne(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnArrowTwo_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[btnArrowTwo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnArrowTwo_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[btnArrowTwo(20)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnOne_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[btnOne(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnTwo_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[btnTwo(50)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnThree_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[btnThree(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnFour_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[btnFour(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        topBorderForBtnOne.addConstraints(topBorderForBtnOne_constraint_V)
        bottomBorderForBtnOne.addConstraints(bottomBorderForBtnOne_constraint_V)
        topBorderForBtnTwo.addConstraints(topBorderForBtnTwo_constraint_V)
        bottomBorderForBtnTwo.addConstraints(bottomBorderForBtnTwo_constraint_V)
        self.btnArrowOne.addConstraints(btnArrowOne_constraint_H)
        self.btnArrowOne.addConstraints(btnArrowOne_constraint_V)
        self.btnArrowTwo.addConstraints(btnArrowTwo_constraint_H)
        self.btnArrowTwo.addConstraints(btnArrowTwo_constraint_V)
        self.btnOne!.addConstraints(btnOne_constraint_V)
        self.btnTwo!.addConstraints(btnTwo_constraint_V)
        self.btnThree.addConstraints(btnThree_constraint_V)
        self.btnFour.addConstraints(btnFour_constraint_V)
        
        let labelOne_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[labelOne]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let labelTwo_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[labelTwo]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnOne_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[btnOne]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let topBorderForBtnOne_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[topBorderForBtnOne]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let bottomBorderForBtnOne_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bottomBorderForBtnOne]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnTwo_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[btnTwo]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let topBorderForBtnTwo_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[topBorderForBtnTwo]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let bottomBorderForBtnTwo_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bottomBorderForBtnTwo]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let clearView_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[labelOne]-10-[topBorderForBtnOne]-0-[btnOne]-0-[bottomBorderForBtnOne]-60-[labelTwo]-10-[topBorderForBtnTwo]-0-[btnTwo]-0-[bottomBorderForBtnTwo]",
            options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnArrowOne_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[btnArrowOne]-15-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnArrowTwo_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:[btnArrowTwo]-15-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnArrowOne_pos_constraint_V = NSLayoutConstraint(item: btnArrowOne, attribute: .CenterY, relatedBy: .Equal, toItem: btnOne, attribute: .CenterY, multiplier: 1, constant: 0)
        let btnArrowTwo_pos_constraint_V = NSLayoutConstraint(item: btnArrowTwo, attribute: .CenterY, relatedBy: .Equal, toItem: btnTwo, attribute: .CenterY, multiplier: 1, constant: 0)
        let btnThree_pos_constraint_H = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[btnThree]-20-[btnFour]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnThree_pos_constraint_V = NSLayoutConstraint.constraintsWithVisualFormat("V:[btnThree]-100-|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let btnFour_pos_constraint_H = NSLayoutConstraint(item: btnFour, attribute: .Width, relatedBy: .Equal, toItem: btnThree, attribute: .Width, multiplier: 1, constant: 0)
        let btnFour_pos_constraint_V = NSLayoutConstraint(item: btnFour, attribute: .CenterY, relatedBy: .Equal, toItem: btnThree, attribute: .CenterY, multiplier: 1, constant: 0)
        
        self.clearView.addConstraints(labelOne_constraint_H)
        self.clearView.addConstraints(labelTwo_constraint_H)
        self.clearView.addConstraints(btnOne_constraint_H)
        self.clearView.addConstraints(topBorderForBtnOne_constraint_H)
        self.clearView.addConstraints(bottomBorderForBtnOne_constraint_H)
        self.clearView.addConstraints(btnTwo_constraint_H)
        self.clearView.addConstraints(topBorderForBtnTwo_constraint_H)
        self.clearView.addConstraints(bottomBorderForBtnTwo_constraint_H)
        self.clearView.addConstraints(clearView_constraint_V)
        self.clearView.addConstraints(btnArrowOne_pos_constraint_H)
        self.clearView.addConstraints(btnArrowTwo_pos_constraint_H)
        self.clearView.addConstraints(btnThree_pos_constraint_H)
        self.clearView.addConstraints(btnThree_pos_constraint_V)
        self.clearView.addConstraint(btnArrowOne_pos_constraint_V)
        self.clearView.addConstraint(btnArrowTwo_pos_constraint_V)
        self.clearView.addConstraint(btnFour_pos_constraint_H)
        self.clearView.addConstraint(btnFour_pos_constraint_V)
    }
}

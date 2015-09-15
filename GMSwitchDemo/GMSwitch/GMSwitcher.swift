//
//  GMSwitcher.swift
//  GMSwitchDemo
//
//  Created by Nguyen Duc Hoang on 9/15/15.
//  Copyright © 2015 Nguyen Duc Hoang. All rights reserved.
//

import UIKit

class GMSwitcher: UIControl {
    private var imgSwitch:UIImageView = UIImageView(image: UIImage(named: "switch-x.png"))
    private var panView:UIView = UIView()
    var minPosision:CGFloat = 0
    var index = 0
    
    var maxPosition:CGFloat = 10
    let gapDistance:CGFloat = 1.5
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    func setupView() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
        self.setupPanView()
        let viewRecognizer = UITapGestureRecognizer(target: self, action:"slideView:")
        self.addGestureRecognizer(viewRecognizer)
    }
    private func setupPanView() {
        panView = UIView()
        self.addSubview(panView);
        panView.frame = CGRectMake(gapDistance, 0, self.frame.height-gapDistance, self.frame.height-gapDistance)
        panView.center = CGPointMake(panView.center.x, self.frame.height/2)
        panView.layer.cornerRadius = panView.frame.size.width/2
        panView.layer.masksToBounds = true
        panView.backgroundColor = UIColor.whiteColor()
        panView.clipsToBounds = true
        let panViewRecognizer = UIPanGestureRecognizer(target: self, action:"slidePanView:")
        panView.addGestureRecognizer(panViewRecognizer)
        panView.addSubview(imgSwitch)
        imgSwitch.center = CGPointMake(panView.frame.size.width/2, panView.frame.size.height/2)
    }
    func slidePanView(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case UIGestureRecognizerState.Changed:
            self.gestureRecognizerChanged(recognizer)
        case .Ended, .Cancelled, .Failed:
            self.gestureRecognizerEnded(recognizer)
        default:
            return
        }
    }
    
    func slideView(recognizer: UIPanGestureRecognizer) {
        let newLocation:CGPoint = recognizer.locationInView(recognizer.view)
        if (newLocation.x < self.frame.width/2) {
            self.switchLeft()
        } else {
            self.switchRight()
        }
    }
    
    func gestureRecognizerChanged(recognizer: UIPanGestureRecognizer) {
        let translate = recognizer.translationInView(recognizer.view)
        recognizer.view!.center.x += translate.x
        recognizer.setTranslation(CGPointZero, inView: recognizer.view)
        maxPosition = panView.bounds.width
        if(panView.frame.origin.x < minPosision) {
            panView.frame.origin.x = minPosision
        } else if(panView.frame.origin.x > maxPosition && panView.frame.origin.x <= self.frame.size.width-panView.bounds.width) {
            panView.frame.origin.x = maxPosition
        } else {
            panView.frame.origin.x = self.frame.size.width-panView.bounds.width 
        }
    }
    
    func gestureRecognizerEnded(recognizer: UIPanGestureRecognizer) {
        
        if(panView.center.x > self.bounds.width/2) {
            self.switchRight()
        } else {
            self.switchLeft()
        }
    }
    func turnOn(switchState:Int) {
        if(switchState == 0) {
            self.switchLeft()
        } else if(switchState == 1) {
            self.switchRight()
        }
    }
    func switchRight() {
        print("switch right", terminator:"\n")
        var panViewFrame:CGRect = panView.frame
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            panViewFrame.origin.x = self.bounds.width - panViewFrame.size.width - self.gapDistance
            self.panView.frame = panViewFrame
            self.panView.backgroundColor = UIColor(red: 75/255, green: 193/255, blue: 210/255, alpha: 1)
            self.imgSwitch.image = UIImage(named: "switch-check.png")
            self.index = 1
        })
    }
    func switchLeft() {
        print("switch left", terminator:"\n")
        var panViewFrame:CGRect = panView.frame
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            panViewFrame.origin.x = self.gapDistance
            self.panView.frame = panViewFrame
            self.panView.backgroundColor = UIColor.whiteColor()
            self.imgSwitch.image = UIImage(named: "switch-x.png")
            self.index = 0
        })
    }
    
}


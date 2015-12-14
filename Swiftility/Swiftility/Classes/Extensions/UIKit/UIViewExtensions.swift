//
//  UIViewExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/22/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import UIKit

extension UIView
{
    // MARK: - PuraScents
    
    class func psTableViewHeaderView(title title: String) -> UIView
    {
        let titleLabel = UILabel()
        
        titleLabel.text = title.uppercaseString
        titleLabel.textColor = UIColor("#3F2B21", alpha: 0.3)
        titleLabel.backgroundColor = UIColor("#F4F2F1")
        titleLabel.font = .psRegular(13)
        titleLabel.textAlignment = .Center
        titleLabel.alpha = 0.7
        
        return titleLabel
    }
    
    // MARK: - Constraints
    
    func addConstraintsWithVisualFormat(format: String, views: [String : UIView] = [:], options: NSLayoutFormatOptions = NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: [String : AnyObject]? = nil)
    {
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views))
    }
    
    // MARK: - Animations
    
    func fadeTransition(duration: CFTimeInterval)
    {
        let animation:CATransition = CATransition()
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration

        self.layer.addAnimation(animation, forKey: kCATransitionFade)
    }
    
    // MARK: - Frame convinience
    
    var size : CGSize {
        get {
            return self.frame.size
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.size.width = value.width;
            newFrame.size.height = value.height;
            self.frame = newFrame
            
        }
    }
    
    var left : CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.x = value;
            self.frame = newFrame;
        }
    }
    
    var top : CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.y = value;
            self.frame = newFrame;
        }
    }
    
    var right : CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.x = value - frame.size.width;
            self.frame = newFrame;
        }
    }
    
    var bottom : CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.y = value - frame.size.height;
            self.frame = newFrame;
        }
    }
    
    
    var width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.size.width = value;
            self.frame = newFrame;
        }
    }
    
    var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.size.height = value;
            self.frame = newFrame;
        }
    }
    
    var centerY : CGFloat {
        get {
            return self.center.y
        }
        
        set(value) {
            self.center = CGPointMake(self.center.x, value)
        }
    }
    
    var centerX : CGFloat {
        get {
            return self.center.x
        }
        
        set(value) {
            self.center = CGPointMake(value, self.center.y);
        }
    }
    
    var bottomMargin : CGFloat {
        get {
            if let unwrappedSuperview = self.superview {
                return unwrappedSuperview.height - self.bottom;
            } else {
                return 0;
            }
        }
        
        set(value) {
            
            if let unwrappedSuperview = self.superview {
                var frame = self.frame;
                frame.origin.y = unwrappedSuperview.height - value - self.height;
                self.frame = frame;
                
            }
        }
    }
    
    
    var rightMargin : CGFloat {
        get {
            if let unwrappedSuperview = self.superview {
                return unwrappedSuperview.width - self.right;
            } else {
                return 0;
            }
        }
        
        set(value) {
            
            if let unwrappedSuperview = self.superview {
                var frame = self.frame;
                frame.origin.y = unwrappedSuperview.width - value - self.width;
                self.frame = frame;
                
            }
        }
    }
    
    
    func centerInSuperview() {
        
        if let u = self.superview {
            self.center = CGPointMake(CGRectGetMidX(u.bounds), CGRectGetMidY(u.bounds));
            
        }
        
    }
    
    func centerVertically() {
        if let unwrappedOptional = self.superview {
            self.center = CGPointMake(self.center.x, CGRectGetMidY(unwrappedOptional.bounds));
        }
    }
    
    func centerHorizontally() {
        if let unwrappedOptional = self.superview {
            self.center = CGPointMake(CGRectGetMidX(unwrappedOptional.bounds), self.center.y);
        }
    }
    
    
    func removeAllSubviews() {
        while(self.subviews.count > 0) {
            if let view: AnyObject =  self.subviews.last {
                view.removeFromSuperview()
            }
        }
        
    }
    
    func makeFrameIntegral() {
        self.frame = CGRectIntegral(self.frame)
        //    self.bounds = CGRectIntegral(self.bounds)
        
    }
}

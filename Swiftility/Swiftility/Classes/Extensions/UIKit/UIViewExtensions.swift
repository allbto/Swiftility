//
//  UIViewExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/22/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit

extension UIView
{
    // MARK: - Constraints
    
    public func addConstraintsWithVisualFormat(format: String, views: [String : UIView] = [:], options: NSLayoutFormatOptions = NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: [String : AnyObject]? = nil)
    {
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views))
    }
    
    // MARK: - Animations
    
    public func fadeTransition(duration: CFTimeInterval)
    {
        let animation:CATransition = CATransition()
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration

        self.layer.addAnimation(animation, forKey: kCATransitionFade)
    }
    
    // MARK: - Frame convinience
    
    public var size : CGSize {
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
    
    public var left : CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.x = value;
            self.frame = newFrame;
        }
    }
    
    public var top : CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.y = value;
            self.frame = newFrame;
        }
    }
    
    public var right : CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.x = value - frame.size.width;
            self.frame = newFrame;
        }
    }
    
    public var bottom : CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.origin.y = value - frame.size.height;
            self.frame = newFrame;
        }
    }
    
    
    public var width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.size.width = value;
            self.frame = newFrame;
        }
    }
    
    public var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(value) {
            var newFrame = self.frame;
            newFrame.size.height = value;
            self.frame = newFrame;
        }
    }
    
    public var centerY : CGFloat {
        get {
            return self.center.y
        }
        
        set(value) {
            self.center = CGPointMake(self.center.x, value)
        }
    }
    
    public var centerX : CGFloat {
        get {
            return self.center.x
        }
        
        set(value) {
            self.center = CGPointMake(value, self.center.y);
        }
    }
    
    public var bottomMargin : CGFloat {
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
    
    
    public var rightMargin : CGFloat {
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
    
    
    public func centerInSuperview() {
        
        if let u = self.superview {
            self.center = CGPointMake(CGRectGetMidX(u.bounds), CGRectGetMidY(u.bounds));
            
        }
        
    }
    
    public func centerVertically() {
        if let unwrappedOptional = self.superview {
            self.center = CGPointMake(self.center.x, CGRectGetMidY(unwrappedOptional.bounds));
        }
    }
    
    public func centerHorizontally() {
        if let unwrappedOptional = self.superview {
            self.center = CGPointMake(CGRectGetMidX(unwrappedOptional.bounds), self.center.y);
        }
    }
    
    
    public func removeAllSubviews() {
        while(self.subviews.count > 0) {
            if let view: AnyObject =  self.subviews.last {
                view.removeFromSuperview()
            }
        }
        
    }
    
    public func makeFrameIntegral() {
        self.frame = CGRectIntegral(self.frame)
        //    self.bounds = CGRectIntegral(self.bounds)
        
    }
}

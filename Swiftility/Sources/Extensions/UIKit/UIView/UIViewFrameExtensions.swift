//
//  UIViewFrameExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 11/10/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

// MARK: - Frame convenience
extension UIView
{
    public var size: CGSize {
        get { return self.frame.size }
        
        set(value) {
            var newFrame = self.frame
            newFrame.size.width = value.width
            newFrame.size.height = value.height
            self.frame = newFrame
        }
    }
    
    public var left: CGFloat {
        get { return self.frame.origin.x }
        
        set(value) {
            var newFrame = self.frame
            newFrame.origin.x = value
            self.frame = newFrame
        }
    }
    
    public var top: CGFloat {
        get { return self.frame.origin.y }
        
        set(value) {
            var newFrame = self.frame
            newFrame.origin.y = value
            self.frame = newFrame
        }
    }
    
    public var right: CGFloat {
        get { return self.frame.origin.x + self.frame.size.width }
        
        set(value) {
            var newFrame = self.frame
            newFrame.origin.x = value - frame.size.width
            self.frame = newFrame
        }
    }
    
    public var bottom: CGFloat {
        get { return self.frame.origin.y + self.frame.size.height }
        
        set(value) {
            var newFrame = self.frame
            newFrame.origin.y = value - frame.size.height
            self.frame = newFrame
        }
    }
    
    public var width: CGFloat {
        get { return self.frame.size.width }
        
        set(value) {
            var newFrame = self.frame
            newFrame.size.width = value
            self.frame = newFrame
        }
    }
    
    public var height: CGFloat {
        get { return self.frame.size.height }
        
        set(value) {
            var newFrame = self.frame
            newFrame.size.height = value
            self.frame = newFrame
        }
    }
    
    public var centerY: CGFloat {
        get { return self.center.y }
        
        set(value) {
            self.center = CGPoint(x: self.center.x, y: value)
        }
    }
    
    public var centerX: CGFloat {
        get { return self.center.x }
        
        set(value) {
            self.center = CGPoint(x: value, y: self.center.y)
        }
    }
    
    // MARK: - Margins
    
    public var bottomMargin: CGFloat {
        get {
            guard let unwrappedSuperview = self.superview else {
                return 0
            }
            
            return unwrappedSuperview.height - self.bottom
        }
        
        set(value) {
            guard let unwrappedSuperview = self.superview else { return }
            
            var frame = self.frame
            frame.origin.y = unwrappedSuperview.height - value - self.height
            self.frame = frame
        }
    }
    
    
    public var rightMargin: CGFloat {
        get {
            guard let unwrappedSuperview = self.superview else {
                return 0
            }
            
            return unwrappedSuperview.width - self.right
        }
        
        set(value) {
            guard let unwrappedSuperview = self.superview else { return }
            
            var frame = self.frame
            frame.origin.y = unwrappedSuperview.width - value - self.width
            self.frame = frame
        }
    }
    
    // MARK: - Center
    
    public func centerInSuperview()
    {
        if let u = self.superview {
            self.center = CGPoint(x: u.bounds.midX, y: u.bounds.midY)
        }
    }
    
    public func centerVertically()
    {
        if let unwrappedOptional = self.superview {
            self.center = CGPoint(x: self.center.x, y: unwrappedOptional.bounds.midY)
        }
    }
    
    public func centerHorizontally()
    {
        if let unwrappedOptional = self.superview {
            self.center = CGPoint(x: unwrappedOptional.bounds.midX, y: self.center.y)
        }
    }
}

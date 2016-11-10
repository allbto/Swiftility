//
//  UIViewExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/22/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit

// MARK: - Convenience init
extension UIView
{
    public convenience init(backgroundColor: UIColor)
    {
        self.init()
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Animations
extension UIView
{
    /// Set hidden with animation using alpha property
    public func setHidden(
        _ hidden: Bool,
        animated: Bool,
        duration: TimeInterval = 0.2,
        customAnimations: (() -> Void)? = nil,
        completion: ((Void) -> Void)? = nil)
    {
        guard hidden != self.isHidden else {
            return
        }
        
        guard animated else {
            self.isHidden = hidden
            self.alpha = hidden ? 0 : 1
            customAnimations?()
            completion?()
            return
        }
        
        self.alpha = hidden ? 1 : 0
        
        if !hidden {
            self.isHidden = false
        }
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .beginFromCurrentState,
            animations: {
                self.alpha = hidden ? 0 : 1
                customAnimations?()
            },
            completion: { finished in
                guard finished else { return }
                
                if hidden {
                    self.isHidden = true
                }
                
                completion?()
            }
        )
    }
}

// MARK: - Screenshot
extension UIView
{
    public func screenshot() -> UIImage?
    {
        let rect = self.bounds
        
        UIGraphicsBeginImageContext(rect.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        self.layer.render(in: context)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return img
    }
}

// MARK: - Subviews
extension UIView
{
    public func removeAllSubviews(recursively: Bool = false)
    {
        while self.subviews.count > 0 {
            if let view = self.subviews.last {
                
                if recursively {
                    view.removeAllSubviews(recursively: recursively)
                }
                
                view.removeFromSuperview()
            }
        }
    }
}

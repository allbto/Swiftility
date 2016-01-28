//
//  UIWindowExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/23/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension UIWindow
{
    public func setRootViewControllerAnimated(vc: UIViewController?, options: UIViewAnimationOptions = .TransitionCrossDissolve, duration: NSTimeInterval = 0.3)
    {
        guard let vc = vc else {
            self.rootViewController = nil
            return
        }

        guard self.rootViewController != nil else {
            self.rootViewController = vc
            return
        }
        
        let transition = CATransition()
        
        transition.duration = duration;
        transition.type = kCATransitionFade
        
        self.layer.addAnimation(transition, forKey:kCATransition)
        self.rootViewController = vc
    }
}
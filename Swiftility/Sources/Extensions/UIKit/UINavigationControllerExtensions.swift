//
//  UINavigationControllerExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/17/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit

public enum UINavigationControllerAnimationStyle
{
    case fade, moveIn, push, reveal
    
    public var CATransitionValue: String {
            switch self {
            case .fade:
                return kCATransitionFade
            case .moveIn:
                return kCATransitionMoveIn
            case .push:
                return kCATransitionPush
            case .reveal:
                return kCATransitionReveal
            }
    }
}

extension UINavigationController
{
    // MARK: - Animation
    
    public func pushViewController(_ vc: UIViewController, animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval = 0.2)
    {
        self.addAnimation(animationType, duration: duration)
        return self.pushViewController(vc, animated: false)
    }
    
    public func popViewController(animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval = 0.2) -> UIViewController?
    {
        self.addAnimation(animationType, duration: duration)
        return self.popViewController(animated: false)
    }

    public func popToRootViewController(animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval = 0.2) -> [UIViewController]?
    {
        self.addAnimation(animationType, duration: duration)
        return self.popToRootViewController(animated: false)
    }

    fileprivate func addAnimation(_ animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval)
    {
        let transition = CATransition()
        
        transition.duration = duration;
        transition.type = animationType.CATransitionValue;
        
        self.view.layer.add(transition, forKey:nil)
    }
    
}

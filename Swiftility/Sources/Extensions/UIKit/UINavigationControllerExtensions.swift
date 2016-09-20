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
    case Fade, MoveIn, Push, Reveal
    
    public var CATransitionValue: String {
            switch self {
            case .Fade:
                return kCATransitionFade
            case .MoveIn:
                return kCATransitionMoveIn
            case .Push:
                return kCATransitionPush
            case .Reveal:
                return kCATransitionReveal
            }
    }
}

extension UINavigationController
{
    // MARK: - Animation
    
    public func pushViewController(vc: UIViewController, animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval = 0.2)
    {
        self.addAnimation(animationType, duration: duration)
        return self.pushViewController(vc, animated: false)
    }
    
    public func popViewController(animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval = 0.2) -> UIViewController?
    {
        self.addAnimation(animationType, duration: duration)
        return self.popViewControllerAnimated(false)
    }

    public func popToRootViewController(animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval = 0.2) -> [UIViewController]?
    {
        self.addAnimation(animationType, duration: duration)
        return self.popToRootViewControllerAnimated(false)
    }

    private func addAnimation(animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval)
    {
        let transition = CATransition()
        
        transition.duration = duration;
        transition.type = animationType.CATransitionValue;
        
        self.view.layer.addAnimation(transition, forKey:nil)
    }
    
}
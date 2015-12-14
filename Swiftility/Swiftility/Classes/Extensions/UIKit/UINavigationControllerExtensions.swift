//
//  UINavigationControllerExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/17/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import UIKit

enum UINavigationControllerAnimationStyle {
    case Fade, MoveIn, Push, Reveal
    
    var CATransitionValue: String
        {
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
    
    func pushViewController(vc: UIViewController, animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval = 0.2)
    {
        self.addAnimation(animationType, duration: duration)
        return self.pushViewController(vc, animated: false)
    }
    
    func popViewController(animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval = 0.2) -> UIViewController?
    {
        self.addAnimation(animationType, duration: duration)
        return self.popViewControllerAnimated(false)
    }

    func popToRootViewController(animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval = 0.2) -> [UIViewController]?
    {
        self.addAnimation(animationType, duration: duration)
        return self.popToRootViewControllerAnimated(false)
    }

    func addAnimation(animationType: UINavigationControllerAnimationStyle, duration: CFTimeInterval)
    {
        let transition = CATransition()
        
        transition.duration = duration;
        transition.type = animationType.CATransitionValue;
        
        self.view.layer.addAnimation(transition, forKey:nil)
    }
    
}
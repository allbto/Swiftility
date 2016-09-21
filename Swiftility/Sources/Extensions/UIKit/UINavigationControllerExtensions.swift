//
//  UINavigationControllerExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/17/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit

public enum CATransitionStyle
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
    
    public func transition(withDuration duration: CFTimeInterval) -> CATransition
    {
        let transition = CATransition()
        
        transition.duration = duration
        transition.type = self.CATransitionValue

        return transition
    }
}

extension UINavigationController
{
    // MARK: - Animation
    
    public func pushViewController(_ vc: UIViewController, animationType: CATransitionStyle, duration: CFTimeInterval = 0.2)
    {
        self._addAnimation(animationType, duration: duration)
        return self.pushViewController(vc, animated: false)
    }
    
    public func popViewController(animationType: CATransitionStyle, duration: CFTimeInterval = 0.2) -> UIViewController?
    {
        self._addAnimation(animationType, duration: duration)
        return self.popViewController(animated: false)
    }

    public func popToRootViewController(animationType: CATransitionStyle, duration: CFTimeInterval = 0.2) -> [UIViewController]?
    {
        self._addAnimation(animationType, duration: duration)
        return self.popToRootViewController(animated: false)
    }

    private func _addAnimation(_ transitionType: CATransitionStyle, duration: CFTimeInterval)
    {
        self.view.layer.add(transitionType.transition(withDuration: duration), forKey: nil)
    }
}

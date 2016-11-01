//
//  UITabBarController.swift
//  Swiftility
//
//  Created by Allan Barbato on 11/2/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension UITabBarController
{
    /// Retrives the first UIViewController matching the type given
    /// by looking at self.viewControllers children and for each the first child if it's a UINavigationController
    public func viewController<T: UIViewController>() -> T?
    {
        guard let vcs = self.viewControllers else { return nil }
        
        for vc in vcs {
            if let vc = vc as? T {
                return vc
            } else if let navVC = vc as? UINavigationController, let vc = navVC.viewControllers.first as? T {
                return vc
            }
        }
        
        return nil
    }
}

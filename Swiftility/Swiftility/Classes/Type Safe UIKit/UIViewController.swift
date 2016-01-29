//
//  UIViewController.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/29/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension FromStoryboard where Self: UIViewController
{
    public static func instanciateFromStoryboard() -> Self
    {
        let storyboardContainer = UIStoryboard(name: self.storyboard.storyboard, bundle: self.storyboard.bundle)
        
        return storyboardContainer.instantiateViewController(Self)
    }
}

extension UIViewController: SelfNibConvertible {}

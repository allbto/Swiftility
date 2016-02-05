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
    public static func instantiateFromStoryboard() -> Self
    {
        return self.ownStoryboard.storyboard.instantiateViewController(Self)
    }
}

extension UIViewController: SelfNibConvertible {}

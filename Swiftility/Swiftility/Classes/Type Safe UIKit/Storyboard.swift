//
//  Storyboard.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/21/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation
import UIKit

// MARK: - StoryboardConvertible

public protocol StoryboardConvertible
{
    var storyboardName: String { get }
    var bundle: NSBundle? { get }
}

extension StoryboardConvertible
{
    public var bundle: NSBundle? {
        return nil
    }
    
    public var storyboard: UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: self.bundle)
    }
}

// MARK: - FromStoryboard

public protocol FromStoryboard
{
    static var ownStoryboard: StoryboardConvertible { get }
}

// MARK: - Type safe instantiate view controller

extension UIStoryboard
{
    public func instantiateInitialViewController<T: UIViewController>(type: T.Type) -> T
    {
        guard let vc = self.instantiateInitialViewController() as? T else {
            fatalError("\(String(type)) could not be instantiated because it was not found in storyboard: \(self)")
        }
        
        return vc
    }

    public func instantiateViewController<T: UIViewController>(type: T.Type) -> T
    {
        guard let vc = self.silentlyInstantiateViewControllerWithIdentifier(String(type)) as? T else {
            fatalError("\(String(type)) could not be instantiated because it was not found in storyboard: \(self)")
        }
        
        return vc
    }
}

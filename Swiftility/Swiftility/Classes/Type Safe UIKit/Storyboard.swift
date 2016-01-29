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
    var storyboard: String { get }
    var bundle: NSBundle? { get }
}

extension StoryboardConvertible
{
    public var bundle: NSBundle? {
        return nil
    }
}

// MARK: - FromStoryboard

public protocol FromStoryboard
{
    static var storyboard: StoryboardConvertible { get }
}

// MARK: - Type safe instantiate view controller

extension UIStoryboard
{
    public func instantiateViewController<T where T: UIViewController>(type: T.Type) -> T
    {
        guard let vc = self.silentlyInstantiateViewControllerWithIdentifier(String(type)) as? T else {
            fatalError("\(String(type)) could not be instantiated because it was not found in storyboard: \(self)")
        }
        
        return vc
    }
}

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
    var bundle: Bundle? { get }
}

extension StoryboardConvertible
{
    public var bundle: Bundle? {
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
    public func instantiateInitialViewController<T: UIViewController>() -> T
    {
        guard let vc = self.instantiateInitialViewController() as? T else {
            fatalError("\(String(describing: T.self)) could not be instantiated because it was not found in storyboard: \(self)")
        }
        
        return vc
    }

    public func instantiateViewController<T: UIViewController>() -> T
    {
        guard let vc = self.silentlyInstantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("\(String(describing: T.self)) could not be instantiated because it was not found in storyboard: \(self)")
        }
        
        return vc
    }
}

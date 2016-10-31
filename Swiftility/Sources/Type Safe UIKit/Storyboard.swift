//
//  Storyboard.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/21/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Storyboard

extension UIStoryboard
{
    public struct Name
    {
        var name: String
        var bundle: Bundle?
        
        init(name: String, bundle: Bundle? = nil)
        {
            self.name = name
            self.bundle = bundle
        }
    }
}

extension UIStoryboard
{
    public convenience init(name: UIStoryboard.Name)
    {
        self.init(name: name.name, bundle: name.bundle)
    }
}

// MARK: - FromStoryboard

public protocol FromStoryboard
{
    static var storyboardName: UIStoryboard.Name { get }
}

// MARK: - Type safe instantiate view controller

extension UIStoryboard
{
    public func instantiateInitialViewController<T: UIViewController>() -> T
    {
        guard let vc = self.instantiateInitialViewController() as? T else {
            sw_fatalError("\(String(describing: T.self)) could not be instantiated because it was not found in storyboard: \(self)")
        }
        
        return vc
    }

    public func instantiateViewController<T: UIViewController>() -> T
    {
        var vc: UIViewController? = nil
        
        do {
            try ObjC.catchException {
                vc = self.instantiateViewController(withIdentifier: String(describing: T.self))
            }
        } catch {
            vc = nil
        }
        
        guard let typedVc = vc as? T else {
            sw_fatalError("\(String(describing: T.self)) could not be instantiated because it was not found in storyboard: \(self)")
        }
        
        return typedVc
    }
}

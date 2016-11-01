//
//  DictionaryExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 6/7/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension Dictionary
{
    /// Convenience call to Dictionary.updateValue for each value of `other`
    public mutating func update(_ other: Dictionary)
    {
        for (key, value) in other {
            self.updateValue(value, forKey: key)
        }
    }
}

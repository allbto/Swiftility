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
    public mutating func update(_ other: Dictionary)
    {
        for (key, value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

//
//  Weak.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/2/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public struct Weak<T: AnyObject>
{
    public weak var value : T?

    public init (_ value: T) {
        self.value = value
    }
}
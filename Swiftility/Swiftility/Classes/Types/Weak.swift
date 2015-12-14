//
//  Weak.swift
//  PuraScents
//
//  Created by Allan Barbato on 10/2/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation

public struct Weak<T: AnyObject>
{
    public weak var value : T?

    public init (_ value: T) {
        self.value = value
    }
}
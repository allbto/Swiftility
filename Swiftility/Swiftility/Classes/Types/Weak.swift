//
//  Weak.swift
//  PuraScents
//
//  Created by Allan Barbato on 10/2/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation

class Weak<T: AnyObject>
{
    weak var value : T?

    init (_ value: T) {
        self.value = value
    }
}
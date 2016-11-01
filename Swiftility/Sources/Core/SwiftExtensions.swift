//
//  SwiftExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/27/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

public func < <T: RawRepresentable>(a: T, b: T) -> Bool where T.RawValue: Comparable
{
    return a.rawValue < b.rawValue
}

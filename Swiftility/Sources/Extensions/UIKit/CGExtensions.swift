//
//  CGExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 11/10/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension CGSize
{
    public static var greatestFiniteMagnitude: CGSize {
        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }
}

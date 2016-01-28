//
//  UINavigationBarExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/16/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension UINavigationBar
{
    public func setTransparent(transparent: Bool)
    {
        self.setBackgroundImage((transparent ? UIImage() : nil), forBarMetrics: .Default)
        self.shadowImage = (transparent ? UIImage() : nil)
        self.translucent = transparent
    }
}
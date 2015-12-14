//
//  UINavigationBarExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 10/16/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation

extension UINavigationBar
{
    func setTransparent(transparent: Bool)
    {
        self.setBackgroundImage((transparent ? UIImage() : nil), forBarMetrics: .Default)
        self.shadowImage = (transparent ? UIImage() : nil)
        self.translucent = transparent
    }
}
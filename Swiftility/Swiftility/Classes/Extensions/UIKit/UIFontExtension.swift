//
//  UIFontExtension.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/25/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import UIKit

extension UIFont
{
    // MARK: - PuraScents
    
    static func psRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Regular", size: size)!
    }

    static func psLight(size: CGFloat) -> UIFont {
        return UIFont(name: "ProximaNova-Light", size: size)!
    }
}
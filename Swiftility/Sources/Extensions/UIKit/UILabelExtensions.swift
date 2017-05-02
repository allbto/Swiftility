//
//  UILabelExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 12/22/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension UILabel
{
    /// Init label with font, textColor and textAlignement
    ///
    /// - Parameters:
    ///   - font: Label font
    ///   - textColor: Label color
    ///   - textAlignment: default .left
    public convenience init(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment = .left)
    {
        self.init()
        
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
}

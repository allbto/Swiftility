//
//  UILabelExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 10/15/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import UIKit

extension UILabel
{
    public func setLetterSpacedText(text: String, spacing: CGFloat)
    {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: text.length))
        
        self.attributedText = attributedString
    }
}
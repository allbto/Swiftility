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
    /**
     Set self.attributedText with attributes for character spacing and line spacing if needed (> 0)
     
     - parameter text:             The text to set
     - parameter characterSpacing: =0; Amount of character spacing. Ignored if == 0
     - parameter lineSpacing:      =0; Amount of line spacing. Ignored if == 0
     - parameter ownAttributes:    =nil; Add your own attributes to the text. Ignored if == nil
     - parameter range:            ={0, text.length}; Range of the string to set attributes to.
     */
    public func setTextWithSpacing(text: String, characterSpacing: CGFloat = 0, lineSpacing: CGFloat = 0, ownAttributes: [String : AnyObject]? = nil, range: NSRange? = nil)
    {
        let range: NSRange = range ?? NSRange(location: 0, length: text.length)
        let attributedString = NSMutableAttributedString(string: text)
        
        // Add own attributes if needed
        if let attrs = ownAttributes {
            attributedString.addAttributes(attrs, range: range)
        }
        
        // Add character spacing if needed
        if characterSpacing > 0 {
            attributedString.addAttribute(NSKernAttributeName, value: characterSpacing, range: range)
        }
        
        // Add line spacing if needed
        if lineSpacing > 0 {
            let paragraphStyle = NSMutableParagraphStyle()
            
            paragraphStyle.lineSpacing = lineSpacing
            
            attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:range)
        }
        
        // Assign text
        self.attributedText = attributedString
    }
}
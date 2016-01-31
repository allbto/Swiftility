//
//  UILabelExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/15/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit

private func _attributedSpacingString(text: String?,
    characterSpacing: CGFloat,
    lineSpacing: CGFloat,
    ownAttributes: [String : AnyObject]?,
    range: NSRange?) -> NSAttributedString?
{
    // If text is nil update label text and leave
    guard let text = text else {
        return nil
    }
    
    let range: NSRange = range ?? NSRange(location: 0, length: text.length)
    let attributedString = NSMutableAttributedString(string: text)
    
    // Add own attributes if needed
    if let attrs = ownAttributes {
        attributedString.addAttributes(attrs, range: range)
    }
    
    // Add character spacing if needed
    if characterSpacing != 0 {
        attributedString.addAttribute(NSKernAttributeName, value: characterSpacing, range: range)
    }
    
    // Add line spacing if needed
    if lineSpacing != 0 {
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpacing
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:range)
    }
    
    return attributedString
}

extension UITextView
{
    /**
     Set self.attributedText with attributes for character spacing and line spacing if needed (> 0)
     
     - parameter text:             The text to set
     - parameter characterSpacing: =0; Amount of character spacing. Ignored if == 0
     - parameter lineSpacing:      =0; Amount of line spacing. Ignored if == 0
     - parameter ownAttributes:    =nil; Add your own attributes to the text. Ignored if == nil
     - parameter range:            ={0, text.length}; Range of the string to set attributes to.
     - parameter preserveFont:     =true; Preserve font after change
     - parameter preserveColor:    =true; Preserve color after change
     */
    public func setTextWithSpacing(text: String?,
        characterSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0,
        ownAttributes: [String : AnyObject]? = nil,
        range: NSRange? = nil,
        preserveFont: Bool = true,
        preserveColor: Bool = true)
    {
        var font: UIFont? = nil
        var color: UIColor? = nil
        
        // Copy font if needed
        if preserveFont {
            font = self.font
        }
        
        // Copy color if needed
        if preserveColor {
            color = self.textColor
        }
        
        // Assign text
        self.attributedText = _attributedSpacingString(text, characterSpacing: characterSpacing, lineSpacing: lineSpacing, ownAttributes: ownAttributes, range: range)
        
        // Reapply font if needed
        if let preservedFont = font {
            self.font = preservedFont
        }
        
        // Reapply color if needed
        if let preservedColor = color {
            self.textColor = preservedColor
        }
    }
    
    /// self.setTextWithSpacing with own text
    public func setSpacing(characterSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0,
        ownAttributes: [String : AnyObject]? = nil,
        range: NSRange? = nil,
        preserveFont: Bool = true,
        preserveColor: Bool = true)
    {
        self.setTextWithSpacing(self.text,
            characterSpacing: characterSpacing,
            lineSpacing: lineSpacing,
            ownAttributes: ownAttributes,
            range: range,
            preserveFont: preserveFont,
            preserveColor: preserveColor)
    }
}

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
    public func setTextWithSpacing(text: String?,
        characterSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0,
        ownAttributes: [String : AnyObject]? = nil,
        range: NSRange? = nil)
    {
        // Assign text
        self.attributedText = _attributedSpacingString(text, characterSpacing: characterSpacing, lineSpacing: lineSpacing, ownAttributes: ownAttributes, range: range)
    }
    
    /// self.setTextWithSpacing with own text
    public func setSpacing(characterSpacing characterSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0,
        ownAttributes: [String : AnyObject]? = nil,
        range: NSRange? = nil)
    {
        self.setTextWithSpacing(self.text,
            characterSpacing: characterSpacing,
            lineSpacing: lineSpacing,
            ownAttributes: ownAttributes,
            range: range)
    }
}


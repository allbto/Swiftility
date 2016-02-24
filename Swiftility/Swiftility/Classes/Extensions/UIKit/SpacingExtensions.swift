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
    
    let attributedString = NSMutableAttributedString(string: text)
    let range: NSRange = range ?? NSRange(location: 0, length: attributedString.length)
    
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
     - parameter preserveAlignment:=true; If alignment should be preserved after setting attributedText
     */
    public func setTextWithSpacing(text: String?,
        characterSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0,
        ownAttributes: [String : AnyObject]? = nil,
        range: NSRange? = nil,
        preserveFont: Bool = true,
        preserveColor: Bool = true,
        preserveAlignment: Bool = true)
    {
        var attrs = ownAttributes ?? [:]
        let alignment = self.textAlignment
        
        // Set font if needed
        if preserveFont && attrs[NSFontAttributeName] == nil {
            attrs[NSFontAttributeName] = self.font
        }
        
        // Set color if needed
        if preserveColor && attrs[NSForegroundColorAttributeName] == nil {
            attrs[NSForegroundColorAttributeName] = self.textColor
        }
        
        // Assign text
        self.attributedText = _attributedSpacingString(text, characterSpacing: characterSpacing, lineSpacing: lineSpacing, ownAttributes: attrs, range: range)
        
        // Set alignment if needed
        if preserveAlignment {
            self.textAlignment = alignment
        }
    }
    
    /// self.setTextWithSpacing with own text
    public func setSpacing(characterSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0,
        ownAttributes: [String : AnyObject]? = nil,
        range: NSRange? = nil,
        preserveFont: Bool = true,
        preserveColor: Bool = true,
        preserveAlignment: Bool = true)
    {
        self.setTextWithSpacing(self.text,
            characterSpacing: characterSpacing,
            lineSpacing: lineSpacing,
            ownAttributes: ownAttributes,
            range: range,
            preserveFont: preserveFont,
            preserveColor: preserveColor,
            preserveAlignment: preserveAlignment)
    }
}

extension UILabel
{
    /**
     Set self.attributedText with attributes for character spacing and line spacing if needed (> 0)
     
     - parameter text:             The text to set
     - parameter characterSpacing: =0; Amount of character spacing. Ignored if == 0
     - parameter lineSpacing:      =0; Amount of line spacing. Ignored if == 0
     - parameter preserveAlignment:=true; If alignment should be preserved after setting attributedText
     - parameter ownAttributes:    =nil; Add your own attributes to the text. Ignored if == nil
     - parameter range:            ={0, text.length}; Range of the string to set attributes to.
     */
    public func setTextWithSpacing(text: String?,
        characterSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0,
        preserveAlignment: Bool = true,
        ownAttributes: [String : AnyObject]? = nil,
        range: NSRange? = nil)
    {
        let alignment = self.textAlignment
        
        // Assign text
        self.attributedText = _attributedSpacingString(text, characterSpacing: characterSpacing, lineSpacing: lineSpacing, ownAttributes: ownAttributes, range: range)
        
        // Set alignment if needed
        if preserveAlignment {
            self.textAlignment = alignment
        }
    }
    
    /// self.setTextWithSpacing with own text
    public func setSpacing(characterSpacing characterSpacing: CGFloat = 0,
        lineSpacing: CGFloat = 0,
        preserveAlignment: Bool = true,
        ownAttributes: [String : AnyObject]? = nil,
        range: NSRange? = nil)
    {
        self.setTextWithSpacing(self.text,
            characterSpacing: characterSpacing,
            lineSpacing: lineSpacing,
            ownAttributes: ownAttributes,
            preserveAlignment: preserveAlignment,
            range: range)
    }
}

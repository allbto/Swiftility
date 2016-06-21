//
//  StringExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/16/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

// MARK: - Operations
extension String
{
    /// Get only String length
    public var length: Int { return self.characters.count }
    
    // MARK: - Subscript

    public subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[self.startIndex.advancedBy(i)])
    }
    
    public subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = startIndex.advancedBy(r.endIndex - r.startIndex)
            
            return self[startIndex..<endIndex]
        }
        
        set {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = startIndex.advancedBy(r.endIndex - r.startIndex)
            
            self.replaceRange(startIndex..<endIndex, with: newValue)
        }
    }
    
    public func trim(set: NSCharacterSet = .whitespaceAndNewlineCharacterSet()) -> String
    {
        return self.stringByTrimmingCharactersInSet(set)
    }
}

// MARK: - Localized
extension String
{
    public var localized: String { return String.localized(self) }
    
    public func localized(comment: String) -> String
    {
        return String.localized(self, comment: comment)
    }
    
    public static func localized(key: String, comment: String? = nil) -> String
    {
        return NSLocalizedString(key, comment: comment ?? key)
    }
}

// MARK: - Size
extension String
{
    public func size(withFont
        font: UIFont,
        constraintSize: CGSize,
        options: NSStringDrawingOptions = .UsesLineFragmentOrigin,
        context: NSStringDrawingContext? = nil) -> CGSize
    {
        let attributes = [NSFontAttributeName: font]
        
        return self.size(withAttributes: attributes, constraintSize: constraintSize, options: options, context: context)
    }
    
    public func size(withAttributes
        attributes: [String: AnyObject],
        constraintSize: CGSize,
        options: NSStringDrawingOptions = .UsesLineFragmentOrigin,
        context: NSStringDrawingContext? = nil) -> CGSize
    {
        var rect = (self as NSString).boundingRectWithSize(constraintSize, options: options, attributes: attributes, context: context)
        
        rect.size.height = CGFloat(ceilf(Float(rect.height)))
        rect.size.width = CGFloat(ceilf(Float(rect.width)))
        
        return rect.size
    }
}

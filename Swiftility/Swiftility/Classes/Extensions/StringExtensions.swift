//
//  StringExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/16/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension String
{
    // MARK: - Length

    /// Get only String length
    public var length: Int { return self.characters.count }
    
    // MARK: - Subscript

    public subscript (i: Int) -> Character {
        get {
            return self[self.startIndex.advancedBy(i)]
        }
    }
    
    public subscript (i: Int) -> String {
        return String(self[self.startIndex.advancedBy(i)])
    }
    
    public subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = startIndex.advancedBy(r.endIndex - r.startIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
    
    // MARK: - Localized

    public var localized: String { return String.localized(self) }
    
    public func localized(comment: String) -> String
    {
        return String.localized(self, comment: comment)
    }
    
    public static func localized(key: String, comment: String? = nil) -> String
    {
        return NSLocalizedString(key, comment: comment ?? key)
    }
    
    // MARK: - Size
    
    public func sizeWithFont(font: UIFont, constraintWidth: CGFloat = CGFloat(MAXFLOAT), constraintHeight: CGFloat = CGFloat(MAXFLOAT)) -> CGSize
    {
        let attributes = [NSFontAttributeName: font]
        var rect = (self as NSString).boundingRectWithSize(CGSizeMake(constraintWidth, constraintHeight), options:.UsesLineFragmentOrigin, attributes:attributes, context:nil)
        
        rect.size.height = CGFloat(ceilf(Float(rect.height)))
        rect.size.width = CGFloat(ceilf(Float(rect.width)))
        
        return rect.size
    }
}
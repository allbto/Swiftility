//
//  StringExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/16/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation

extension String
{
    // MARK: - Length

    var length: Int { return self.characters.count }
    
    // MARK: - Subscript
    
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = startIndex.advancedBy(r.endIndex - r.startIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
    
    // MARK: - Localized

    var localized: String { return String.localized(self) }
    
    func localized(comment: String) -> String
    {
        return String.localized(self, comment: comment)
    }
    
    static func localized(key: String, comment: String? = nil) -> String
    {
        return NSLocalizedString(key, comment: comment ?? key)
    }
    
    // MARK: - Size
    
    func sizeWithFont(font: UIFont, constraintWidth: CGFloat = CGFloat(MAXFLOAT), constraintHeight: CGFloat = CGFloat(MAXFLOAT)) -> CGSize
    {
        let attributes = [NSFontAttributeName: font]
        var rect = (self as NSString).boundingRectWithSize(CGSizeMake(constraintWidth, constraintHeight), options:.UsesLineFragmentOrigin, attributes:attributes, context:nil)
        
        rect.size.height = CGFloat(ceilf(Float(rect.height)))
        rect.size.width = CGFloat(ceilf(Float(rect.width)))
        
        return rect.size
    }
}
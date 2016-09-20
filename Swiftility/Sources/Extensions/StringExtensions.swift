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
    }
    
    public func trim(set: NSCharacterSet = .whitespaceAndNewlineCharacterSet()) -> String
    {
        return self.stringByTrimmingCharactersInSet(set)
    }

    public var words: [String] {
        var result = [String]()
        
        enumerateSubstringsInRange(startIndex..<endIndex, options: .ByWords) {
            (substring, substringRange, enclosingRange, stop) in
            
            if let substring = substring {
                result.append(substring)
            }
        }
        
        return result
    }
    
    public func inserting(string: String, index: Int) -> String
    {
        return String(self.characters.prefix(index)) + string + String(self.characters.suffix(self.characters.count - index))
    }

    public func URLEncoded() -> String?
    {
        guard let characters = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as? NSMutableCharacterSet else { return nil }
        
        characters.removeCharactersInString("&")
        
        guard let encodedString = self.stringByAddingPercentEncodingWithAllowedCharacters(characters) else { return nil }
        
        return encodedString
    }
    
    public func range(from nsRange: NSRange) -> Range<Index>?
    {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        
        if let
            from = Index(from16, within: self),
            to = Index(to16, within: self)
        {
            return from ..< to
        }
        
        return nil
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

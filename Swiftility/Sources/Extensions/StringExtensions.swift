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
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: i)])
    }
    
    public subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
            
            return self[startIndex..<endIndex]
        }
    }
    
    // MARK: - Utils
    
    public func trimmed(set: CharacterSet = .whitespacesAndNewlines) -> String
    {
        return self.trimmingCharacters(in: set)
    }
    
    /// Returns an array of words from a string. Removes any characters that aren't [a-zA-Z0-9]
    public var words: [String] {
        var result = [String]()
        
        enumerateSubstrings(in: startIndex..<endIndex, options: .byWords) {
            (substring, substringRange, enclosingRange, stop) in
            
            if let substring = substring {
                result.append(substring)
            }
        }
        
        return result
    }
    
    public func urlEncoded() -> String?
    {
        var allowedCharacters = CharacterSet.urlQueryAllowed
        
        allowedCharacters.remove(charactersIn: ";?/:&=+$,~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    // MARK: - Range
    
    public func range(from nsRange: NSRange) -> Range<Index>?
    {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = Index(from16, within: self),
            let to = Index(to16, within: self)
            else { return nil }
        
        return from ..< to
    }
}

// MARK: - Localized
extension String
{
    public var localized: String { return String.localized(self) }
    
    public func localized(_ comment: String) -> String
    {
        return String.localized(self, comment: comment)
    }
    
    public static func localized(_ key: String, comment: String? = nil) -> String
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
        options: NSStringDrawingOptions = .usesLineFragmentOrigin,
        context: NSStringDrawingContext? = nil) -> CGSize
    {
        let attributes = [NSFontAttributeName: font]
        
        return self.size(withAttributes: attributes, constraintSize: constraintSize, options: options, context: context)
    }
    
    public func size(withAttributes
        attributes: [String: AnyObject],
        constraintSize: CGSize,
        options: NSStringDrawingOptions = .usesLineFragmentOrigin,
        context: NSStringDrawingContext? = nil) -> CGSize
    {
        var rect = (self as NSString).boundingRect(with: constraintSize, options: options, attributes: attributes, context: context)
        
        rect.size.height = CGFloat(ceilf(Float(rect.height)))
        rect.size.width = CGFloat(ceilf(Float(rect.width)))
        
        return rect.size
    }
}

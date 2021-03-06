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
    // MARK: - Subscript
    
    /// Get Character at index
    public subscript (i: String.IndexDistance) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }

    /// Get Character as String at index
    public subscript (i: String.IndexDistance) -> String {
        return String(self[self.index(self.startIndex, offsetBy: i)])
    }

    /// Get Substring at range
    public subscript (r: Range<String.IndexDistance>) -> Substring {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)

            return self[startIndex..<endIndex]
        }
    }

    // MARK: - Utils
    
    public func truncated(_ length: Int) -> String
    {
        guard length >= 0 && length < self.count else { return self }
        
        return String(self[0..<length])
    }
    
    /// Returns trimmed string (remove newlines and whitespaces at the beginning and the end)
    public func trimmed(set: CharacterSet = .whitespacesAndNewlines) -> String
    {
        return self.trimmingCharacters(in: set)
    }
    
    /// Returns an array of words from a string
    /// Removes any characters that aren't [a-zA-Z0-9]
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
    
    /// Returns an url encoded version of the String
    /// Example: "My Name&urlInjection=true" -> "My%20Name%26urlInjection%3Dtrue"
    public func urlEncoded() -> String?
    {
        var allowedCharacters = CharacterSet.urlQueryAllowed
        
        allowedCharacters.remove(charactersIn: ";?/:&=+$,~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    /// Determine if self is a valid email by matching it against regex /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/
    /// Check http://emailregex.com/ for more info.
    public var isValidEmail: Bool {
        return self.match(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
    }
    
    // MARK: - Range
    
    /// Transforms an NSRange into a Range<Index> if possible
    /// Usefull when using APIs that uses NSRange like UITextView
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
    /// Returns a localized version of the string
    public var localized: String { return String.localized(self) }
    
    /// Returns a localized version of the string with specified comment
    public func localized(_ comment: String) -> String
    {
        return String.localized(self, comment: comment)
    }
    
    /// Returns a localized version of key with specified comment
    public static func localized(_ key: String, comment: String? = nil) -> String
    {
        return NSLocalizedString(key, comment: comment ?? key)
    }
}

// MARK: - Size
extension String
{
    /// Conveniance call to NSString.boundingRect
    public func size(withFont
        font: UIFont,
        constraintSize: CGSize,
        options: NSStringDrawingOptions = .usesLineFragmentOrigin,
        context: NSStringDrawingContext? = nil) -> CGSize
    {
        let attributes = [NSAttributedStringKey.font: font]
        
        return self.size(withAttributes: attributes, constraintSize: constraintSize, options: options, context: context)
    }
    
    /// Conveniance call to NSString.boundingRect
    public func size(withAttributes
        attributes: [NSAttributedStringKey: Any],
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

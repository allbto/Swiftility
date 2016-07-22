//
//  Regex.swift
//  Swiftility
//
//  Created by Allan Barbato on 12/16/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public struct Regex
{
    public var pattern: String {
        didSet {
            do {
                try updateRegex()
            } catch {
                print("Impossible to update regex")
            }
        }
    }
    
    public var expressionOptions: NSRegularExpressionOptions {
        didSet {
            do {
                try updateRegex()
            } catch {
                print("Impossible to update regex")
            }
        }
    }
    
    public var matchingOptions: NSMatchingOptions
    
    public private(set) var regex: NSRegularExpression?
    
    public init(pattern: String, expressionOptions: NSRegularExpressionOptions = NSRegularExpressionOptions(rawValue: 0), matchingOptions: NSMatchingOptions = NSMatchingOptions(rawValue: 0)) throws
    {
        self.pattern = pattern
        self.expressionOptions = expressionOptions
        self.matchingOptions = matchingOptions
        try updateRegex()
    }
    
    public mutating func updateRegex() throws
    {
        regex = try NSRegularExpression(pattern: pattern, options: expressionOptions)
    }
}

infix operator =~ {}

public func =~ (input: String, pattern: String) -> Bool
{
    return input.match(pattern: pattern)
}

extension String
{
    public func match(regex regex: Regex) -> Bool
    {
        return !matches(forRegex: regex).isEmpty
    }
    
    public func match(pattern pattern: String) -> Bool
    {
        do {
            return self.match(regex: try Regex(pattern: pattern))
        } catch {
            return false
        }
    }
    
    public func matches(forRegex pattern: Regex) -> [[String]]
    {
        let range: NSRange = NSMakeRange(0, self.length)
        let nsString = self as NSString
        
        if let regex = pattern.regex {
            let matches = regex.matchesInString(self, options: pattern.matchingOptions, range: range)
            
            return matches.map {
                var ranges = [String]()
                
                for i in 0 ..< $0.numberOfRanges {
                    let range = $0.rangeAtIndex(i)
                    
                    guard range.location != NSNotFound else { break }
                    
                    ranges.append(nsString.substringWithRange(range))
                }
                
                return ranges
            }
        }
        
        return []
    }
    
    public func matches(forPattern patternString: String) -> [[String]]
    {
        do {
            return self.matches(forRegex: try Regex(pattern: patternString))
        } catch {
            return []
        }
    }
    
    public func replace(regex regex: Regex, template: String) -> String
    {
        if self.match(regex: regex) {
            let range: NSRange = NSMakeRange(0, self.length)
            
            if let reg = regex.regex {
                return reg.stringByReplacingMatchesInString(self, options: regex.matchingOptions, range: range, withTemplate: template)
            }
        }
        return self
    }
    
    public func replace(pattern: String, template: String) -> String
    {
        do {
            return self.replace(regex: try Regex(pattern: pattern), template: template)
        } catch {
            return self
        }
    }
}
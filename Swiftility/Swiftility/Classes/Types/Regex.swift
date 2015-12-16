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
    return input.match(pattern)
}

extension String
{
    public func matchRegex(pattern: Regex) -> Bool
    {
        let range: NSRange = NSMakeRange(0, self.length)

        if let regex = pattern.regex {
            let matches: [AnyObject] = regex.matchesInString(self, options: pattern.matchingOptions, range: range)
            return matches.count > 0
        }
        return false
    }
    
    public func match(patternString: String) -> Bool
    {
        do {
            return self.matchRegex(try Regex(pattern: patternString))
        } catch {
            return false
        }
    }
    
    public func replaceRegex(pattern: Regex, template: String) -> String
    {
        if self.matchRegex(pattern) {
            let range: NSRange = NSMakeRange(0, self.length)
            
            if let regex = pattern.regex {
                return regex.stringByReplacingMatchesInString(self, options: pattern.matchingOptions, range: range, withTemplate: template)
            }
        }
        return self
    }
    
    public func replace(pattern: String, template: String) -> String
    {
        do {
            return self.replaceRegex(try Regex(pattern: pattern), template: template)
        } catch {
            return self
        }
    }
}
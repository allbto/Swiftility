//
//  Regex.swift
//  Swiftility
//
//  Created by Allan Barbato on 12/16/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

// TODO: Review implementation of Regex

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
    
    public var expressionOptions: NSRegularExpression.Options {
        didSet {
            do {
                try updateRegex()
            } catch {
                print("Impossible to update regex")
            }
        }
    }
    
    public var matchingOptions: NSRegularExpression.MatchingOptions
    
    public fileprivate(set) var regex: NSRegularExpression?
    
    public init(pattern: String, expressionOptions: NSRegularExpression.Options = NSRegularExpression.Options(rawValue: 0), matchingOptions: NSRegularExpression.MatchingOptions = NSRegularExpression.MatchingOptions(rawValue: 0)) throws
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

infix operator =~

public func =~ (input: String, pattern: String) -> Bool
{
    return input.match(pattern: pattern)
}

extension String
{
    public func match(regex pattern: Regex) -> Bool
    {
        let range: NSRange = NSMakeRange(0, self.count)
        
        if let regex = pattern.regex {
            return !regex.matches(in: self, options: pattern.matchingOptions, range: range).isEmpty
        }

        return false
    }
    
    public func match(pattern: String) -> Bool
    {
        do {
            return self.match(regex: try Regex(pattern: pattern))
        } catch {
            return false
        }
    }
    
    public func matches(forRegex pattern: Regex) -> [[String]]
    {
        let range: NSRange = NSMakeRange(0, self.count)
        let nsString = self as NSString
        
        if let regex = pattern.regex {
            let matches = regex.matches(in: self, options: pattern.matchingOptions, range: range)
            
            return matches.map {
                var ranges = [String]()
                
                for i in 0 ..< $0.numberOfRanges {
                    let range = $0.range(at: i)
                    
                    guard range.location != NSNotFound else { break }
                    
                    ranges.append(nsString.substring(with: range))
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
    
    public func replace(regex: Regex, template: String) -> String
    {
        if self.match(regex: regex) {
            let range: NSRange = NSMakeRange(0, self.count)
            
            if let reg = regex.regex {
                return reg.stringByReplacingMatches(in: self, options: regex.matchingOptions, range: range, withTemplate: template)
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

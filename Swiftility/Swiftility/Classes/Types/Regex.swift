//
//  Regex.swift
//  Swiftility
//
//  Created by Allan Barbato on 12/16/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

class Regex
{
    private(set) var internalExpression: NSRegularExpression!
    let pattern: String
    
    init(_ pattern: String, options: NSRegularExpressionOptions = [.CaseInsensitive]) throws
    {
        self.pattern = pattern
        self.internalExpression = nil

        self.internalExpression = try NSRegularExpression(pattern: pattern, options: options)
    }
    
    func test(input: String, options: NSMatchingOptions = NSMatchingOptions(rawValue: 0), range: NSRange? = nil) -> Bool
    {
        let matches = self.internalExpression.matchesInString(input, options: options, range:range ?? NSMakeRange(0, input.length))
        return matches.count > 0
    }
}

infix operator =~ {}

func =~ (input: String, pattern: String) -> Bool
{
    do {
        return try Regex(pattern).test(input)
    } catch {
        return false
    }
}
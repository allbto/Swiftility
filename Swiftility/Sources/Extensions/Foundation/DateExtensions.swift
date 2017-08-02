//
//  DateExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/17/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension TimeZone {
    public static var gmt: TimeZone { return TimeZone(secondsFromGMT: 0)! }
}

extension Date {
    
    // MARK: - Convenience
    
    public static func from(_ date: String, format: String, locale: Locale = .current, timeZone: TimeZone = .current) -> Date? {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        
        return formatter.date(from: date)
    }
    
    public func format(_ format: String, locale: Locale = .current, timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        
        return formatter.string(from: self)
    }
    
    public func date(byAdding value: Int, _ component: Calendar.Component, calendar: Calendar = .current) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self)
    }
    
    public func date(bySetting component: Calendar.Component, to value: Int, calendar: Calendar = .current) -> Date? {
        return calendar.date(bySetting: component, value: value, of: self)
    }
    
    public func component(_ component: Calendar.Component, calendar: Calendar = .current) -> Int {
        return calendar.component(component, from: self)
    }
    
    // MARK: - String representation
    
    /// Easier to read string representation of date
    public var relativeValue: String {
        let formatter = DateFormatter()
        
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        
        return formatter.string(from: self)
    }
    
}

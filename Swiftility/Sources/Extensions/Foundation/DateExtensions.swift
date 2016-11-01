//
//  DateExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/17/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension Date
{
    // MARK: - Convenience
    
    public static func date(from: String, format: String, locale: Locale = .current, timeZone: TimeZone = .current) -> Date?
    {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        
        return formatter.date(from: from)
    }
    
    public func date(byAdding value: Int, component: Calendar.Component, calendar: Calendar = .current) -> Date?
    {
        var components = DateComponents()
        
        components.setValue(value, for: component)

        return calendar.date(byAdding: components, to: self)
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

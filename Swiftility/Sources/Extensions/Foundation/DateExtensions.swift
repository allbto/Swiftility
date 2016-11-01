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
    
    // MARK: - Hour date
    
    public func component(_ component: Calendar.Component, calendar: Calendar = .current) -> Int
    {
        return calendar.component(component, from: self)
    }
    
    /// Return a new NSDate base on `initialDate`, only keeping self's hour, minutes & seconds
    public func hourDate(
        initialDate: Date = Date(timeIntervalSince1970: 0),
        includeMinutes: Bool = true,
        includeSeconds: Bool = false,
        calendar: Calendar = .current,
        timeZone: TimeZone = .current) -> Date?
    {
        var components = DateComponents()
        
        components.year = initialDate.component(.year)
        components.month = initialDate.component(.month)
        components.day = initialDate.component(.day)
        components.hour = self.component(.hour)
        
        if includeMinutes {
            components.minute = self.component(.minute)
        } else {
            components.minute = 0
        }
        
        if includeSeconds {
            components.second = self.component(.second)
        } else {
            components.second = 0
        }
        
        components.timeZone = timeZone
        
        return calendar.date(from: components)
    }
    
    /// Return a new NSDate, only keeping self's hour, minutes & seconds
    public var hourDate: Date? {
        return self.hourDate()
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

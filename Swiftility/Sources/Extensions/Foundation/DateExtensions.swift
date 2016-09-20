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
    
    public static func date(from: String, format: String) -> Date?
    {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        
        return formatter.date(from: from)
    }
    
    public func date(byAdding value: Int, toComponent component: Calendar.Component, onCalendar calendar: Calendar = .current) -> Date?
    {
        var components = DateComponents()
        
        components.setValue(value, for: component)

        return calendar.date(byAdding: components, to: self)
    }
    
    // MARK: - Hour date
    
    public func component(_ component: Calendar.Component, onCalendar calendar: Calendar = .current) -> Int
    {
        return calendar.component(component, from: self)
    }
    
    /// Return a new NSDate base on `initialDate`, only keeping the hour, minutes & seconds
    public func hourDate(
        initialDate: Date = Date(timeIntervalSince1970: 0),
        includeMinutes: Bool = true,
        includeSeconds: Bool = false,
        onCalendar calendar: Calendar = .current,
        andTimeZone timeZone: TimeZone = .current) -> Date?
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
    
    public var hourDate: Date? {
        return self.hourDate()
    }
    
    // MARK: - String representation
    
    public var relativeValue: String {
        let formatter = DateFormatter()
        
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        
        return formatter.string(from: self)
    }
}

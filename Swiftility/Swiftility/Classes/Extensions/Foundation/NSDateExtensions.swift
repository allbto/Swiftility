//
//  NSDateExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/17/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable { }

extension NSDate
{
    // MARK: - Convinience
    
    public static func dateFromString(fromString: String, format: String) -> NSDate?
    {
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = format
        formatter.locale = NSLocale.currentLocale()
        formatter.timeZone = NSTimeZone.systemTimeZone()
        
        return formatter.dateFromString(fromString)
    }
    
    public func dateByAddingValue(value: Int, toUnit unit: NSCalendarUnit, onCalendar calendar: NSCalendar = .currentCalendar()) -> NSDate
    {
        let components: NSDateComponents = NSDateComponents()
        
        components.setValue(value, forComponent: unit)

        return calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(rawValue: 0)) ?? self
    }
    
    // MARK: - Hour date
    
    public func component(unit: NSCalendarUnit, onCalendar calendar: NSCalendar = .currentCalendar()) -> Int
    {
        return calendar.component(unit, fromDate: self)
    }
    
    /// Return a new NSDate base on `initialDate`, only keeping the hour, minutes & seconds
    public func hourDate(
        initialDate initialDate: NSDate = NSDate(timeIntervalSince1970: 0),
        includeMinutes: Bool = true,
        includeSeconds: Bool = false,
        onCalendar calendar: NSCalendar = .currentCalendar(),
        andTimeZone timeZone: NSTimeZone = .systemTimeZone()) -> NSDate
    {
        let components = NSDateComponents()
        
        components.year = initialDate.component(.Year)
        components.month = initialDate.component(.Month)
        components.day = initialDate.component(.Day)
        components.hour = self.component(.Hour)
        
        if includeMinutes {
            components.minute = self.component(.Minute)
        } else {
            components.minute = 0
        }
        
        if includeSeconds {
            components.second = self.component(.Second)
        } else {
            components.second = 0
        }
        
        components.timeZone = timeZone
        
        return calendar.dateFromComponents(components)!
    }
    
    public var hourDate: NSDate {
        return self.hourDate()
    }
    
    // MARK: - String representation
    
    public var relativeValue: String {
        let formatter = NSDateFormatter()
        
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .ShortStyle
        formatter.doesRelativeDateFormatting = true
        
        return formatter.stringFromDate(self)
    }
}

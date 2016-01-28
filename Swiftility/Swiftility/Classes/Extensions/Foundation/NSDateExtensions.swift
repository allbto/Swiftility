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
    
    public static func dateFromString(fromString: String, format: String = "yyyy-MM-dd HH:mm:ss zzz") -> NSDate?
    {
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = format
        formatter.locale = NSLocale.currentLocale()
        formatter.timeZone = NSTimeZone.systemTimeZone()
        
        return formatter.dateFromString(fromString)
    }
    
    public func dateByAddingValue(value: Int, toUnit unit: NSCalendarUnit, onCalendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> NSDate
    {
        let components: NSDateComponents = NSDateComponents()
        
        components.setValue(value, forComponent: unit)

        return calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(rawValue: 0)) ?? self
    }
    
    // MARK: - Hour date
    
    public func component(unit: NSCalendarUnit, onCalendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> Int
    {
        return calendar.component(unit, fromDate: self)
    }
    
    public func hourDate(initialDate date: NSDate = NSDate(timeIntervalSince1970: 0), includeMinutes: Bool = true, includeSeconds: Bool = false) -> NSDate
    {
        let firstDate = date
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        
        components.year = firstDate.component(.Year)
        components.month = firstDate.component(.Month)
        components.day = firstDate.component(.Day)
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
        
        components.timeZone = NSTimeZone.systemTimeZone()
        
        return calendar.dateFromComponents(components)!
    }
    
    public var hourDate: NSDate {
        return self.hourDate()
    }
    
    // MARK: - String representation
    
    public func stringValue(ends ends: NSDate? = nil, format: String = "ha") -> String
    {
        // TODO: Am pm for US only
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = "h"
        
        let startsString = formatter.stringFromDate(self)
        
        formatter.AMSymbol = "am"; formatter.PMSymbol = "pm"
        formatter.dateFormat = format
        
        if let ends = ends {
            let endsString = formatter.stringFromDate(ends)
            
            return "\(startsString)-\(endsString)"
        } else {
            let startS = formatter.stringFromDate(self)
            
            return "\(startS)"
        }
    }
    
    public var relativeValue: String {
        let formatter = NSDateFormatter()
        
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .ShortStyle
        formatter.doesRelativeDateFormatting = true
        
        return formatter.stringFromDate(self)
    }
}

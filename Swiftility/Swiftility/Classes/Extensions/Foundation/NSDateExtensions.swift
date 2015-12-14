//
//  NSDateExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/17/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
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
    
    static func dateFromString(fromString: String, format: String = "yyyy-MM-dd HH:mm:ss zzz") -> NSDate?
    {
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = format
        formatter.locale = NSLocale.currentLocale()
        formatter.timeZone = NSTimeZone.systemTimeZone()
        
        return formatter.dateFromString(fromString)
    }
    
    func dateByAddingValue(value: Int, toUnit unit: NSCalendarUnit, onCalendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> NSDate
    {
        let components: NSDateComponents = NSDateComponents()
        
        components.setValue(value, forComponent: unit)

        return calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(rawValue: 0)) ?? self
    }
    
    // MARK: - Hour date
    
    func component(unit: NSCalendarUnit, onCalendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> Int
    {
        return calendar.component(unit, fromDate: self)
    }
    
    func hourDate(initialDate date: NSDate = NSDate(timeIntervalSince1970: 0), includeMinutes: Bool = true, includeSeconds: Bool = false) -> NSDate
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
    
    var hourDate: NSDate {
        return self.hourDate()
    }
    
    // MARK: - String representation
    
    func stringValue(ends ends: NSDate? = nil, format: String = "ha") -> String
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
}

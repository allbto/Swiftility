//
//  WeakTimer.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/23/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public class WeakTimer: NSObject
{
    // MARK: - Properties
    
    private var timer: NSTimer!
    private let callback: () -> Void

    // MARK: - Life cycle
    
    private init(timeInterval: NSTimeInterval, userInfo: AnyObject?, repeats: Bool, callback: () -> Void)
    {
        self.callback = callback
        super.init()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "invokeCallback", userInfo: userInfo, repeats: repeats)
    }

    // MARK: - Actions
    
    func invokeCallback()
    {
        callback()
    }

    // MARK: - Public
    
    /**
    A factory for NSTimer instances that invoke closures, thereby allowing a weak reference to its context
    
    - parameter timeInterval: Interval
    - parameter userInfo:     =nil; userInfo object
    - parameter repeats:      =false; Should repeat or called only once
    - parameter callback:     callback called instead of NSTimer target's selector
    
    - returns: new scheduled timer. More info, see: NSTimer.scheduledTimerWithTimeInterval
    */
    public static func scheduledTimerWithTimeInterval(timeInterval: NSTimeInterval, userInfo: AnyObject? = nil, repeats: Bool = false, callback: () -> Void) -> NSTimer
    {
        return WeakTimer(timeInterval: timeInterval, userInfo: userInfo, repeats: repeats, callback: callback).timer
    }
}


//
//  WeakTimer.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/23/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

private extension Selector
{
    static let invokeCallback = #selector(WeakTimer.invokeCallback)
}

public final class WeakTimer: NSObject
{
    // MARK: - Properties
    
    fileprivate var timer: Timer!
    fileprivate let callback: () -> Void

    // MARK: - Life cycle
    
    fileprivate init(timeInterval: TimeInterval,
                 userInfo: AnyObject?,
                 repeats: Bool,
                 callback: @escaping () -> Void)
    {
        self.callback = callback
        
        super.init()

        self.timer = Timer.scheduledTimer(
            timeInterval: timeInterval,
            target: self,
            selector: .invokeCallback,
            userInfo: userInfo,
            repeats: repeats
        )
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
    open static func scheduledTimerWithTimeInterval(
        _ timeInterval: TimeInterval,
        userInfo: AnyObject? = nil,
        repeats: Bool = false,
        callback: @escaping () -> Void) -> Timer
    {
        return WeakTimer(
            timeInterval: timeInterval,
            userInfo: userInfo,
            repeats: repeats,
            callback: callback
        ).timer
    }
}


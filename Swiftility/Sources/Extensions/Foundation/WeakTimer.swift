//
//  WeakTimer.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/23/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension Timer
{
    /**
     A factory for Timer instances that invoke closures, thereby allowing a weak reference to its context
     
     - parameter timeInterval: Interval
     - parameter userInfo:     =nil; userInfo object
     - parameter repeats:      =false; Should repeat or called only once
     - parameter callback:     callback called instead of NSTimer target's selector
     
     - returns: new scheduled timer. More info, see: Timer.scheduledTimer(:_)
     */
    public static func scheduledTimer(
        timeInterval: TimeInterval,
        userInfo: Any? = nil,
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

private extension Selector
{
    static let invokeCallback = #selector(WeakTimer.invokeCallback)
}

private final class WeakTimer: NSObject
{
    // MARK: - Properties
    
    fileprivate var timer: Timer!
    fileprivate let callback: () -> Void

    // MARK: - Life cycle
    
    fileprivate init(timeInterval: TimeInterval,
                 userInfo: Any?,
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
    
    @objc func invokeCallback()
    {
        callback()
    }
}


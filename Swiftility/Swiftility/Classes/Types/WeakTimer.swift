//
//  WeakTimer.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/23/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation

/// A factory for NSTimer instances that invoke closures, thereby allowing a weak reference to its context.
struct WeakTimerFactory {
    class WeakTimer: NSObject {
        private var timer: NSTimer!
        private let callback: () -> Void
        
        private init(timeInterval: NSTimeInterval, userInfo: AnyObject?, repeats: Bool, callback: () -> Void) {
            self.callback = callback
            super.init()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "invokeCallback", userInfo: userInfo, repeats: repeats)
        }
        
        func invokeCallback() {
            callback()
        }
    }
    
    /// Returns a new timer that has not yet executed, and is not scheduled for execution.
    static func timerWithTimeInterval(timeInterval: NSTimeInterval, userInfo: AnyObject?, repeats: Bool, callback: () -> Void) -> NSTimer {
        return WeakTimer(timeInterval: timeInterval, userInfo: userInfo, repeats: repeats, callback: callback).timer
    }
}
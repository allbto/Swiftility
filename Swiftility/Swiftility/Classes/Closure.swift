//
//  Closure.swift
//  PuraScents
//
//  Created by Allan Barbato on 10/23/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation

typealias BasicClosure = dispatch_block_t

// MARK: - Async

/// Convenience call to dispatch_async
func async(queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block: BasicClosure)
{
    dispatch_async(queue, block)
}

/// Convenience call to dispatch_async:dispatch_get_main_queue()
func async_main(block: BasicClosure)
{
    dispatch_async(dispatch_get_main_queue(), block)
}

// MARK: - Debounce

/// Convenience call to dispatch_debounce_block
func debounced(wait : NSTimeInterval, queue : dispatch_queue_t = dispatch_get_main_queue(), closure: BasicClosure) -> BasicClosure
{
    return dispatch_debounce_block(wait, queue: queue, closure: closure)
}

/**
 Creates and returns a new debounced version of the passed block which will postpone its execution until after wait seconds have elapsed since the last time it was invoked.
 It is like a bouncer at a discotheque. He will act only after you shut up for some time.
 This technique is important if you have action wich should fire on update, however the updates are to frequent.
 
 Inspired by debounce function from underscore.js ( http://underscorejs.org/#debounce )
 */
func dispatch_debounce_block(wait : NSTimeInterval, queue : dispatch_queue_t = dispatch_get_main_queue(), closure: BasicClosure) -> BasicClosure
{
    var cancelable : BasicClosure!
    return {
        cancelable?()
        cancelable = dispatch_after_cancellable(dispatch_time(DISPATCH_TIME_NOW, Int64(wait * Double(NSEC_PER_SEC))), queue: queue, closure: closure)
    }
}

func dispatch_after_cancellable(when: dispatch_time_t, queue: dispatch_queue_t, closure: BasicClosure) -> BasicClosure {
    var isCancelled = false
    dispatch_after(when, queue) {
        if !isCancelled {
            closure()
        }
    }
    
    return {
        isCancelled = true
    }
}


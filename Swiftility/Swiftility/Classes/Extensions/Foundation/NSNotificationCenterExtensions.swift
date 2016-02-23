//
//  NSNotificationCenterExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/26/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension NSNotificationCenter
{
    public func addObserverWithName(name: String,
        object obj: AnyObject? = nil,
        queue: NSOperationQueue? = nil,
        usingBlock block: (NSNotification) -> Void) -> NSObjectProtocol
    {
        return self.addObserverForName(name, object: obj, queue: queue, usingBlock: block)
    }
    
    public func addObserverWithNames(names: [String],
        object obj: AnyObject? = nil,
        queue: NSOperationQueue? = nil,
        usingBlock block: (NSNotification) -> Void) -> [NSObjectProtocol]
    {
        return names.map { self.addObserverForName($0, object: obj, queue: queue, usingBlock: block) }
    }
}
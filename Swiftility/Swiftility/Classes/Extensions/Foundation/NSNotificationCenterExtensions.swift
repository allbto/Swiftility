//
//  NSNotificationCenterExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 10/26/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation

extension NSNotificationCenter
{
    func addObserverWithName(name: String, object obj: AnyObject? = nil, queue: NSOperationQueue? = nil, usingBlock block: (NSNotification) -> Void)
    {
        self.addObserverForName(name, object: obj, queue: queue, usingBlock: block)
    }

    func addObserverWithNames(names: [String], object obj: AnyObject? = nil, queue: NSOperationQueue? = nil, usingBlock block: (NSNotification) -> Void)
    {
        names.forEach {
            self.addObserverForName($0, object: obj, queue: queue, usingBlock: block)
        }
    }
}
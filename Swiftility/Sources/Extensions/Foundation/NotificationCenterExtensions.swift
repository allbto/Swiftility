//
//  NotificationCenterExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/26/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension NotificationCenter
{
    /// NSNotificationCenter.addObserver:forName with default parameters
    public func addObserver(withName name: NSNotification.Name,
        object obj: Any? = nil,
        queue: OperationQueue? = nil,
        usingBlock block: @escaping (Notification) -> Void) -> NSObjectProtocol
    {
        return self.addObserver(forName: name, object: obj, queue: queue, using: block)
    }
    
    /// Applying NSNotificationCenter.addObserverWithName for all the notifications in `names`
    public func addObserver(withNames names: [NSNotification.Name],
        object obj: Any? = nil,
        queue: OperationQueue? = nil,
        usingBlock block: @escaping (Notification) -> Void) -> [NSObjectProtocol]
    {
        return names.map { self.addObserver(forName: $0, object: obj, queue: queue, using: block) }
    }
    
    /// Applying NSNotificationCenter.removeObserver to list of observers
    public func removeObservers(_ observers: [Any])
    {
        observers.forEach {
            self.removeObserver($0)
        }
    }
}

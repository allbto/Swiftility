//
//  ArrayExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/15/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension Array
{
     /**
     Allow to fetch object optionally
     
     - parameter index: index to fetch
     
     - returns: Element of Array or nil if out of bounds
     */
    public func get(index: Int?) -> Element?
    {
        if let index = index where index < self.count && index >= 0 {
            return self[index]
        }
        
        return nil
    }
    
     /**
     Remove an object of the array and return the index removed
    
     - parameter object: object to remove
     
     - returns: index of the removed element or nil if not found
     */
    public mutating func remove<U: Equatable>(object: U) -> Int?
    {
        for (index, objectToCompare) in enumerate() {
            if let to = objectToCompare as? U {
                if object == to {
                    self.removeAtIndex(index)
                    return index
                }
            }
        }
        return nil
    }
}


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
    public func get(_ index: Int) -> Element?
    {
        if index < self.count && index >= 0 {
            return self[index]
        }
        
        return nil
    }
    
     /**
     Removes the first object matching the passed object
    
     - parameter object: object to remove
     
     - returns: index of the removed element or nil if not found
     */
    public mutating func remove<U: Equatable>(_ object: U) -> Int?
    {
        for (index, objectToCompare) in self.enumerated() {
            if let to = objectToCompare as? U, object == to {
                self.remove(at: index)
                return index
            }
        }

        return nil
    }
}


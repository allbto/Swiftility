//
//  ArrayExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/15/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation

extension Array
{
    /**
    Add a func to Array allowing to fetch object optionally
    
    :param: index to fetch
    
    :returns: Element of Array or nil if out of bounds
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
    
    :param: object to remove
    
    :returns: index of the removed element
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
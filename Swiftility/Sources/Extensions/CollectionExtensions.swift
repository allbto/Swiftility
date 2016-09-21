//
//  CollectionExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 7/5/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension Collection
{
    /// Returns an `Array` containing the results of mapping `transform`
    /// over `self`. Filters out the nil values.
    ///
    /// - Complexity: O(N).
    public func mapOptional<T>(_ transform: (Self.Iterator.Element) throws -> T?) rethrows -> [T]
    {
        let count: Int = numericCast(self.count)
        guard count > 0 else { return [] }
        
        var results = [T]()
        
        results.reserveCapacity(count)
        
        for element in self {
            if let transformed = try transform(element) {
                results.append(transformed)
            }
        }
        
        return results
    }
}

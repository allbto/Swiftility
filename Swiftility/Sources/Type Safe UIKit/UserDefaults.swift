//
//  UserDefaults.swift
//  Swiftility
//
//  Created by Allan Barbato on 11/1/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

/// Extends UserDefaults to use a system similar to NSNotification.Name
extension UserDefaults
{
    public struct Key: RawRepresentable, Equatable, Hashable, Comparable {
        public var rawValue: String
        
        public init(rawValue: String)
        {
            self.rawValue = rawValue
        }
    }
    
    open func object(forKey defaultName: Key) -> Any? { return self.object(forKey: defaultName.rawValue) }
    open func string(forKey defaultName: Key) -> String? { return self.string(forKey: defaultName.rawValue) }
    open func array(forKey defaultName: Key) -> [Any]? { return self.array(forKey: defaultName.rawValue) }
    open func data(forKey defaultName: Key) -> Data? { return self.data(forKey: defaultName.rawValue) }
    open func stringArray(forKey defaultName: Key) -> [String]? { return self.stringArray(forKey: defaultName.rawValue) }
    open func integer(forKey defaultName: Key) -> Int { return self.integer(forKey: defaultName.rawValue) }
    open func float(forKey defaultName: Key) -> Float { return self.float(forKey: defaultName.rawValue) }
    open func double(forKey defaultName: Key) -> Double { return self.double(forKey: defaultName.rawValue) }
    open func bool(forKey defaultName: Key) -> Bool { return self.bool(forKey: defaultName.rawValue) }
    open func url(forKey defaultName: Key) -> URL? { return self.url(forKey: defaultName.rawValue) }
    open func dictionary(forKey defaultName: Key) -> [String : Any]? { return self.dictionary(forKey: defaultName.rawValue) }
    
    open func removeObject(forKey defaultName: Key) { self.removeObject(forKey: defaultName.rawValue) }
    open func set(_ value: Any?, forKey defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ value: Int, forKey defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ value: Float, forKey defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ value: Double, forKey defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ value: Bool, forKey defaultName: Key) { self.set(value, forKey: defaultName.rawValue) }
    open func set(_ url: URL?, forKey defaultName: Key) { self.set(url, forKey: defaultName.rawValue) }
    
    open func register(defaults registrationDictionary: [Key : Any])
    {
        let defaults: [String: Any] = registrationDictionary.reduce([:]) { (res, entry) in
            var res = res
            res.updateValue(entry.value, forKey: entry.key.rawValue)
            return res
        }
        
        self.register(defaults: defaults)
    }
}

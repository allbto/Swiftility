//
//  Nib.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/29/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

// MARK: - NibConvertible

public protocol NibConvertible
{
    var nibName: String { get }
    var bundle: Bundle? { get }
}

extension NibConvertible
{
    public var bundle: Bundle? {
        return nil
    }
    
    public var nib: UINib {
        return UINib(nibName: self.nibName, bundle: self.bundle)
    }
}

// MARK: - From nib

public protocol FromNib
{
    static var ownNib: NibConvertible { get }
}

extension FromNib
{
    public static func instantiateFromNib(_ nib: NibConvertible? = nil, owner: Any? = nil, options: [AnyHashable: Any]? = nil) -> Self
    {
        let nibName: String = nib?.nibName ?? self.ownNib.nibName
        let bundle: Bundle = nib?.bundle ?? self.ownNib.bundle ?? Bundle.main
        
        guard let view = bundle.loadNibNamed(nibName, owner: owner, options: options)?.first as? Self else {
            fatalError("\(String(describing: self)) could not be instantiated because it was not found on this bundle or the nib (\(nibName)) did not contain \(String(describing: self))")
        }
        
        return view
    }
}

// MARK: - SelfNibConvertible

public protocol SelfNibConvertible {}

extension SelfNibConvertible
{
    public static var ownNib: NibConvertible {
        return NibContainer(String(describing: Self.self))
    }
}

public struct NibContainer: NibConvertible
{
    fileprivate var _name: String
    fileprivate var _bundle: Bundle?
    
    public init(_ name: String, bundle: Bundle? = nil)
    {
        _name = name
        _bundle = bundle
    }
    
    public var nibName: String {
        return _name
    }
    
    public var bundle: Bundle? {
        return _bundle
    }
}

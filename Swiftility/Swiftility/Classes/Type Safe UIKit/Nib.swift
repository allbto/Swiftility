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
    var bundle: NSBundle? { get }
}

extension NibConvertible
{
    public var bundle: NSBundle? {
        return nil
    }
    
    public var nib: UINib {
        return UINib(nibName: self.nibName, bundle: self.bundle)
    }
}

// MARK: - From nib

public protocol FromNib
{
    static var nib: NibConvertible { get }
}

extension FromNib
{
    public static func instantiateFromNib(nib: NibConvertible? = nil, owner: AnyObject? = nil, options: [NSObject : AnyObject]? = nil) -> Self
    {
        let nibName: String = nib?.nibName ?? self.nib.nibName
        let bundle: NSBundle = nib?.bundle ?? self.nib.bundle ?? NSBundle.mainBundle()
        
        guard let view = bundle.loadNibNamed(nibName, owner: owner, options: options).first as? Self else {
            fatalError("\(String(self)) could not be instantiated because it was not found main bundle or the nib (\(nibName)) did not contain \(String(self))")
        }
        
        return view
    }
}

// MARK: - SelfNibConvertible

public protocol SelfNibConvertible {}

extension SelfNibConvertible
{
    public static var nib: NibConvertible {
        return NibContainer(String(Self))
    }
}

public struct NibContainer: NibConvertible
{
    private var _name: String
    private var _bundle: NSBundle?
    
    public init(_ name: String, bundle: NSBundle? = nil)
    {
        _name = name
        _bundle = bundle
    }
    
    public var nibName: String {
        return _name
    }
    
    public var bundle: NSBundle? {
        return _bundle
    }
}

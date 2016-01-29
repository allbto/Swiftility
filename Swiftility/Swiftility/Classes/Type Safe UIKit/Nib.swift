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
}

// MARK: - From nib

public protocol FromNib
{
    static var nib: NibConvertible { get }
}

extension FromNib
{
    public static func instantiateFromNib(nib: NibConvertible? = nil) -> Self
    {
        let nibName: String = nib?.nibName ?? self.nib.nibName
        let bundle: NSBundle = nib?.bundle ?? self.nib.bundle ?? NSBundle.mainBundle()
        
        guard let view = bundle.loadNibNamed(nibName, owner: nil, options: nil).first as? Self else {
            fatalError("\(String(self)) could not be instantiated because it was not found main bundle or the nib (\(nibName)) did not contain \(String(self))")
        }
        
        return view
    }
}

// MARK: - SelfNibConvertible

public protocol SelfNibConvertible: FromNib {}

extension SelfNibConvertible
{
    public static var nib: NibConvertible {
        return SelfNibContainer(String(Self))
    }
}

private struct SelfNibContainer: NibConvertible
{
    private var name: String
    
    init(_ name: String)
    {
        self.name = name
    }
    
    var nibName: String {
        return name
    }
}

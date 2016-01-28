//
//  UIColorExtension.swift
//  Swiftility
//
//  Created by Allan Barbato on 05/01/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Better RGBA inits
extension UIColor
{
    public convenience init(_ hex: Int, withAlpha alpha: CGFloat = 1.0)
    {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
    
    public convenience init(_ hexString: String, alpha: CGFloat = 1.0)
    {
        // Replace #if found
        let hex = hexString.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hex)
        var color: UInt32 = 0
        
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask) / 255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask) / 255.0)
        let b = CGFloat(Float(Int(color) & mask) / 255.0)
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }

    public convenience init(realRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1)
    {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
}

// MARK: - String values
extension UIColor
{
    public typealias RGBComponents = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    
    public var rgbComponents: RGBComponents {
        var c: RGBComponents = (0,0,0,0)
        
        if getRed(&c.red, green: &c.green, blue: &c.blue, alpha: &c.alpha) {
            return c
        }
        
        return (0,0,0,0)
    }
    
    public var rgbValue: String {
        let components = rgbComponents
        
        return String(format: "#%02x%02x%02x", Int(components.red * 255), Int(components.green * 255), Int(components.blue * 255))
    }
    
    public var rgbaValue: String {
        let components = rgbComponents

        return String(format: "#%02x%02x%02x%02x", Int(components.red * 255), Int(components.green * 255), Int(components.blue * 255), Int(components.alpha * 255) )
    }
}

// MARK: - Hue
extension UIColor
{
    public func lighter(amount : CGFloat = 0.25) -> UIColor
    {
        if amount < 0 { return self }
        
        return self.adjust(red: amount, green: amount, blue: amount, alpha: 0)
    }
    
    public func darker(amount : CGFloat = 0.25) -> UIColor
    {
        if amount < 0 { return self }

        let amount = 0 - amount
        return self.adjust(red: amount, green: amount, blue: amount, alpha: 0)
    }
    
    public func adjust(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha:CGFloat) -> UIColor
    {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)

        return UIColor(red: r+red, green: g+green, blue: b+blue, alpha: a+alpha)
    }
}

// MARK: - Random
extension UIColor
{
    public static func randomColor(opaque isOpaque: Bool = true) -> UIColor
    {
        let hue: CGFloat = ( CGFloat(arc4random()) % 256 / 256.0 );  //  0.0 to 1.0
        let saturation: CGFloat = ( CGFloat(arc4random()) % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        let brightness: CGFloat = ( CGFloat(arc4random()) % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        var alpha: CGFloat = 1;
        
        if (!isOpaque) {
            alpha = ( CGFloat(arc4random()) % 128 / 256.0 ) + 0.5;
        }
        
        return UIColor(hue:hue, saturation:saturation, brightness:brightness, alpha:alpha)
    }
}







//
//  UIColorExtension.swift
//  Swiftility
//
//  Created by Allan Barbato on 05/01/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit

// MARK: - Better rgb init
extension UIColor
{
    /// Instantiate UIColor with real rgb values instead of percentages
    /// E.g UIColor(red: 1, green: 0, blue: 1, alpha: 1) == UIColor(realRed: 255, green: 0, blue: 255, alpha: 255)
    public convenience init(realRed: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    {
        self.init(red: realRed / 255, green: green / 255, blue: blue / 255, alpha: alpha / 255)
    }
}

// MARK: - Hexadecimal
extension UIColor
{
    /// Instantiate UIColor with hexadecimal number such as 0xFFFFFF for white or 0x000000 for black
    public convenience init(_ hex: Int, alpha: CGFloat = 1.0)
    {
        // Apply mask
        let mask = 0xFF
        let components = (
            R: CGFloat((hex >> 16) & mask),
            G: CGFloat((hex >> 08) & mask),
            B: CGFloat((hex >> 00) & mask)
        )
        
        // Init
        self.init(realRed: components.R, green: components.G, blue: components.B, alpha: alpha * 255)
    }
    
    /// Instantiate UIColor with hexadecimal number as String such as "FFFFFF" for white or "000000" for black
    /// # is ignored such as "#FFFFFF" -> "FFFFFF"
    public convenience init(_ hex: String, withAlpha alpha: CGFloat = 1.0)
    {
        // Replace '#' if found
        let hex = hex.replacingOccurrences(of: "#", with: "")

        // Scan value
        let scanner = Scanner(string: hex)
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        // Apply mask
        let mask = 0xFF
        let components = (
            R: CGFloat(Int(color >> 16) & mask),
            G: CGFloat(Int(color >> 8) & mask),
            B: CGFloat(Int(color) & mask)
        )
        
        // Init
        self.init(realRed: components.R, green: components.G, blue: components.B, alpha: alpha * 255)
    }
    
    /// Returns the hexadecimal value of the color as a String
    /// E.g: UIColor.red.rgbValue -> "ff0000"
    public var rgbValue: String {
        let components = rgbComponents
        return String(format: "%02x%02x%02x", Int(components.red * 255), Int(components.green * 255), Int(components.blue * 255))
    }
    
    /// Returns the hexadecimal value, including alpha, of the color as a String
    /// E.g: UIColor.red.rgbaValue -> "ff0000ff"
    /// E.g: UIColor.red.withAlphaComponent(0).rgbaValue -> "ff000000"
    public var rgbaValue: String {
        let components = rgbComponents
        return String(format: "%02x%02x%02x%02x", Int(components.red * 255), Int(components.green * 255), Int(components.blue * 255), Int(components.alpha * 255) )
    }
}

// MARK: - RGBComponents extensions
extension UIColor
{
    public typealias RGBComponents = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    
    /// Returns rgb components of a color
    public var rgbComponents: RGBComponents {
        var c: RGBComponents = (0,0,0,0)
        
        if getRed(&c.red, green: &c.green, blue: &c.blue, alpha: &c.alpha) {
            return c
        }
        
        return (0,0,0,0)
    }
 
    /// Returns 0 -> 1 Float representing the percentage of brightness of the color
    public var brightness: CGFloat {
        let components = rgbComponents
        return ((components.red * 299) + (components.green * 587) + (components.blue * 114)) / 1000
    }
}

// MARK: - Image
extension UIColor
{
    /// Returns an UIImage representation of the color
    public var image: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)

        UIGraphicsBeginImageContext(rect.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        context.setFillColor(self.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        return image
    }
}

// MARK: - Hue
extension UIColor
{
    public func lighter(_ amount: CGFloat = 0.25) -> UIColor
    {
        if amount < 0 { return self }
        
        return self.adjust(red: amount, green: amount, blue: amount, alpha: 0)
    }
    
    public func darker(_ amount : CGFloat = 0.25) -> UIColor
    {
        if amount < 0 { return self }
        
        let amount = 0 - amount
        return self.adjust(red: amount, green: amount, blue: amount, alpha: 0)
    }
    
    public func adjust(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor
    {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return UIColor(red: r+red, green: g+green, blue: b+blue, alpha: a+alpha)
    }
}

//
//  UIColorExtension.swift
//  runandonly
//
//  Created by Jan Remes on 05.01.15.
//  Copyright (c) 2015 Jan Remes. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    // MARK: - Better RGBA inits
    
    // MARK: - Better RGBA inits 
    
    convenience init(_ rgba: String, var alpha: CGFloat=1.0) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        
        let index   = rgba.hasPrefix("#") ? rgba.startIndex.advancedBy(1) : rgba.startIndex
        let hex     = rgba.substringFromIndex(index)
        let scanner = NSScanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexLongLong(&hexValue) {
            switch (hex.length) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
            }
        } else {
            print("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
	class func rgb(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
		return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
	}
    
    typealias RGBComponents = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    
    var rgbComponents:RGBComponents {
        var c:RGBComponents = (0,0,0,0)
        
        if getRed(&c.red, green: &c.green, blue: &c.blue, alpha: &c.alpha) {
            return c
        }
        
        return (0,0,0,0)
    }
    
    var rgbValue: String {
        return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255), Int(rgbComponents.blue * 255))
    }
    
    var rgbaValue: String {
        return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255), Int(rgbComponents.blue * 255), Int(rgbComponents.alpha * 255) )
    }
    
    
    // HUE
    
    func lighter(amount : CGFloat = 0.25) -> UIColor {
        if amount < 0 { return self }
        
        return self.adjust(red: amount, green: amount, blue: amount, alpha: 0)
    }
    
    func darker(amount : CGFloat = 0.25) -> UIColor {
        if amount < 0 { return self }

        let amount = 0 - amount
        return self.adjust(red: amount, green: amount, blue: amount, alpha: 0)
    }
    
    func adjust(red red: CGFloat, green: CGFloat, blue: CGFloat, alpha:CGFloat) -> UIColor{
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: r+red, green: g+green, blue: b+blue, alpha: a+alpha)
    }
    
    // Random
    
    static func randomColor(opaque isOpaque: Bool = true) -> UIColor!
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







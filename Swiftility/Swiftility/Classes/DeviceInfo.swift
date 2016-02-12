//
//  DeviceInfo.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/16/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Device Structure
public struct DeviceInfo
{
    // MARK: - Singletons
    
    public static var currentDevice: UIDevice {
        return UIDevice.currentDevice()
    }
    
    public static var currentDeviceVersion: Float {
        return (UIDevice.currentDevice().systemVersion as NSString).floatValue
    }
    
    public static var currentDeviceHeight: CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }
    
    // MARK: - Device Idiom Checks
    
    public static func isPhone() -> Bool
    {
        return currentDevice.userInterfaceIdiom == .Phone
    }
    
    public static func isPad() -> Bool
    {
        return currentDevice.userInterfaceIdiom == .Pad
    }
    
    // MARK: - Device Version Checks
    
    public static func isVersion(version: Float) -> Bool
    {
        return currentDeviceVersion >= version && currentDeviceVersion < (version + 1.0)
    }
    
    public static func isVersionOrLater(version: Float) -> Bool
    {
        return currentDeviceVersion >= version
    }
    
    public static func isVersionOrEarlier(version: Float) -> Bool
    {
        return currentDeviceVersion < (version + 1.0)
    }
    
    // MARK: - Device Size Checks
    
    public enum Heights: CGFloat {
        case Inches_3_5 = 480
        case Inches_4 = 568
        case Inches_4_7 = 667
        case Inches_5_5 = 736
    }
    
    public static func isSize(height: Heights) -> Bool
    {
        return currentDeviceHeight == height.rawValue
    }
    
    public static func isSizeOrLarger(height: Heights) -> Bool
    {
        return currentDeviceHeight >= height.rawValue
    }
    
    public static func isSizeOrSmaller(height: Heights) -> Bool
    {
        return currentDeviceHeight <= height.rawValue
    }
    
    // MARK: Retina Check
    
    public static func isRetina() -> Bool
    {
        return UIScreen.mainScreen().respondsToSelector("scale")
    }
}

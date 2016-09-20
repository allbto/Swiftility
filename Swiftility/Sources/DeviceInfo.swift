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
        return UIDevice.current
    }
    
    public static var currentDeviceVersion: Float {
        return (UIDevice.current.systemVersion as NSString).floatValue
    }
    
    public static var currentDeviceHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    // MARK: - Device Idiom Checks
    
    public static func isPhone() -> Bool
    {
        return currentDevice.userInterfaceIdiom == .phone
    }
    
    public static func isPad() -> Bool
    {
        return currentDevice.userInterfaceIdiom == .pad
    }
    
    // MARK: - Device Version Checks
    
    public static func isVersion(_ version: Float) -> Bool
    {
        return currentDeviceVersion >= version && currentDeviceVersion < (version + 1.0)
    }
    
    public static func isVersionOrLater(_ version: Float) -> Bool
    {
        return currentDeviceVersion >= version
    }
    
    public static func isVersionOrEarlier(_ version: Float) -> Bool
    {
        return currentDeviceVersion < (version + 1.0)
    }
    
    // MARK: - Device Size Checks
    
    public enum Heights: CGFloat {
        case inches_3_5 = 480
        case inches_4 = 568
        case inches_4_7 = 667
        case inches_5_5 = 736
    }
    
    public static func isSize(_ height: Heights) -> Bool
    {
        return currentDeviceHeight == height.rawValue
    }
    
    public static func isSizeOrLarger(_ height: Heights) -> Bool
    {
        return currentDeviceHeight >= height.rawValue
    }
    
    public static func isSizeOrSmaller(_ height: Heights) -> Bool
    {
        return currentDeviceHeight <= height.rawValue
    }
    
    // MARK: Retina Check
    
    public static func isRetina() -> Bool
    {
        return UIScreen.main.scale == 2.0
    }
}

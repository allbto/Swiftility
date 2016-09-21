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
    
    public static var current: UIDevice {
        return UIDevice.current
    }
    
    public static var currentVersion: Float {
        return (UIDevice.current.systemVersion as NSString).floatValue
    }
    
    public static var currentHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    // MARK: - Device Idiom Checks
    
    public static func isPhone() -> Bool
    {
        return current.userInterfaceIdiom == .phone
    }
    
    public static func isPad() -> Bool
    {
        return current.userInterfaceIdiom == .pad
    }
    
    // MARK: - Device Version Checks
    
    public static func isVersion(_ version: Float) -> Bool
    {
        return currentVersion >= version && currentVersion < (version + 1.0)
    }
    
    public static func isVersionOrLater(_ version: Float) -> Bool
    {
        return currentVersion >= version
    }
    
    public static func isVersionOrEarlier(_ version: Float) -> Bool
    {
        return currentVersion < (version + 1.0)
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
        return currentHeight == height.rawValue
    }
    
    public static func isSizeOrLarger(_ height: Heights) -> Bool
    {
        return currentHeight >= height.rawValue
    }
    
    public static func isSizeOrSmaller(_ height: Heights) -> Bool
    {
        return currentHeight <= height.rawValue
    }
    
    // MARK: Retina Check
    
    public static func isRetina() -> Bool
    {
        return UIScreen.main.scale == 2.0
    }
}

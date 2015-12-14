//
//  Device.swift
//  PuraScents
//
//  Created by Allan Barbato on 10/16/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Device Structure

public struct DeviceInfo {
    
    // MARK: - Singletons
    
    public static var currentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.currentDevice()
        }
        return Singleton.device
    }
    
    public static var currentDeviceVersion: Float {
        struct Singleton {
            static let version = (UIDevice.currentDevice().systemVersion as NSString).floatValue
        }
        return Singleton.version
    }
    
    public static var currentDeviceHeight: CGFloat {
        struct Singleton {
            static let height = UIScreen.mainScreen().bounds.size.height
        }
        return Singleton.height
    }
    
    // MARK: - Device Idiom Checks
    
    public static func isPhone() -> Bool {
        return currentDevice.userInterfaceIdiom == .Phone
    }
    
    public static func isPad() -> Bool {
        return currentDevice.userInterfaceIdiom == .Pad
    }
    
    // MARK: - Device Version Checks
    
    public enum Versions: Float {
        case Five = 5.0
        case Six = 6.0
        case Seven = 7.0
        case Eight = 8.0
    }
    
    public static func isVersion(version: Versions) -> Bool {
        return currentDeviceVersion >= version.rawValue && currentDeviceVersion < (version.rawValue + 1.0)
    }
    
    public static func isVersionOrLater(version: Versions) -> Bool {
        return currentDeviceVersion >= version.rawValue
    }
    
    public static func isVersionOrEarlier(version: Versions) -> Bool {
        return currentDeviceVersion < (version.rawValue + 1.0)
    }
    
    // MARK: iOS 5 Checks
    
    public static func IS_OS_5() -> Bool {
        return isVersion(.Five)
    }
    
    public static func IS_OS_5_OR_LATER() -> Bool {
        return isVersionOrLater(.Five)
    }
    
    public static func IS_OS_5_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Five)
    }
    
    // MARK: iOS 6 Checks
    
    public static func IS_OS_6() -> Bool {
        return isVersion(.Six)
    }
    
    public static func IS_OS_6_OR_LATER() -> Bool {
        return isVersionOrLater(.Six)
    }
    
    public static func IS_OS_6_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Six)
    }
    
    // MARK: iOS 7 Checks
    
    public static func IS_OS_7() -> Bool {
        return isVersion(.Seven)
    }
    
    public static func IS_OS_7_OR_LATER() -> Bool {
        return isVersionOrLater(.Seven)
    }
    
    public static func IS_OS_7_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Seven)
    }
    
    // MARK: iOS 8 Checks
    
    public static func IS_OS_8() -> Bool {
        return isVersion(.Eight)
    }
    
    public static func IS_OS_8_OR_LATER() -> Bool {
        return isVersionOrLater(.Eight)
    }
    
    public static func IS_OS_8_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.Eight)
    }
    
    // MARK: - Device Size Checks
    
    enum Heights: CGFloat {
        case Inches_3_5 = 480
        case Inches_4 = 568
        case Inches_4_7 = 667
        case Inches_5_5 = 736
    }
    
    public static func isSize(height: Heights) -> Bool {
        return currentDeviceHeight == height.rawValue
    }
    
    public static func isSizeOrLarger(height: Heights) -> Bool {
        return currentDeviceHeight >= height.rawValue
    }
    
    public static func isSizeOrSmaller(height: Heights) -> Bool {
        return currentDeviceHeight <= height.rawValue
    }
    
    // MARK: Retina Check
    
    public static func IS_RETINA() -> Bool {
        return UIScreen.mainScreen().respondsToSelector("scale")
    }
    
    // MARK: 3.5 Inch Checks
    
    public static func IS_3_5_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_3_5)
    }
    
    public static func IS_3_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_3_5)
    }
    
    public static func IS_3_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.Inches_3_5)
    }
    
    // MARK: 4 Inch Checks
    
    public static func IS_4_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_4)
    }
    
    public static func IS_4_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4)
    }
    
    public static func IS_4_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrSmaller(.Inches_4)
    }
    
    // MARK: 4.7 Inch Checks
    
    public static func IS_4_7_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_4_7)
    }
    
    public static func IS_4_7_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4_7)
    }
    
    public static func IS_4_7_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_4_7)
    }
    
    // MARK: 5.5 Inch Checks
    
    public static func IS_5_5_INCHES() -> Bool {
        return isPhone() && isSize(.Inches_5_5)
    }
    
    public static func IS_5_5_INCHES_OR_LARGER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_5_5)
    }
    
    public static func IS_5_5_INCHES_OR_SMALLER() -> Bool {
        return isPhone() && isSizeOrLarger(.Inches_5_5)
    }
}
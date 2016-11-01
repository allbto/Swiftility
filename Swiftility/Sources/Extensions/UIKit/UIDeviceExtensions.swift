//
//  UIDeviceExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/16/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Properties
extension UIDevice
{
    public var version: Float {
        return (self.systemVersion as NSString).floatValue
    }

    public var isPhone: Bool {
        return self.userInterfaceIdiom == .phone
    }
    
    public var isPad: Bool {
        return self.userInterfaceIdiom == .pad
    }

    public var isRetina: Bool {
        return UIScreen.main.scale == 2.0
    }
    
    public var size: CGSize {
        return UIScreen.main.bounds.size
    }
}

// MARK: - Size
extension UIDevice
{
    public enum DeviceSize: CGFloat
    {
        case inches_3_5 = 480
        case inches_4 = 568
        case inches_4_7 = 667
        case inches_5_5 = 736
    }

    public var deviceSize: DeviceSize {
        guard let size = DeviceSize(rawValue: self.size.height) else {
            sw_fatalError("Size not handled")
        }

        return size
    }
}

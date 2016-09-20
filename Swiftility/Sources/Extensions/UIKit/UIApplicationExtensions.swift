//
//  UIApplicationExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 12/21/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

extension UIApplication
{
    // MARK: - Settings
    
    public func openSettings()
    {
        self.openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    // MARK: - Push notifications
    
    public func hasAllowedPushNotifications() -> Bool
    {
        return self.currentUserNotificationSettings()!.types != .None
    }
}
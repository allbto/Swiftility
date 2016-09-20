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
    
    @available(iOS, introduced: 2.0, deprecated: 10.0, message: "Please use openSettings:options:completionHandler: instead")
    public func openSettings()
    {
        let url = URL(string: UIApplicationOpenSettingsURLString)!
        
        self.openURL(url)
    }
    
    @available(iOS 10.0, *)
    public func openSettings(options: [String : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil)
    {
        let url = URL(string: UIApplicationOpenSettingsURLString)!
        
        self.open(url, options: options, completionHandler: completion)
    }
    
    // MARK: - Push notifications
    
    @available(iOS, introduced: 8.0, deprecated: 10.0, message: "Use UserNotifications Framework's UNAuthorizationOptions")
    public func hasAllowedPushNotifications() -> Bool
    {
        guard let types = currentUserNotificationSettings?.types else { return false }
        
        return types != UIUserNotificationType()
    }
}

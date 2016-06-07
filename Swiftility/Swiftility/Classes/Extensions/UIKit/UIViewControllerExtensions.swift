//
//  UIViewControllerExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/25/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit
import ObjectiveC

// MARK: - Alert
extension UIViewController
{
    public typealias UIAlertControllerButtonHandler = ((UIAlertAction) -> Void)
    public typealias UIAlertControllerCompletion = (() -> Void)
    
    public func alert(message: String, title: String? = nil, handler: UIAlertControllerButtonHandler? = nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: handler)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

// MARK: - Keyboard
extension UIViewController
{
    /// Update closure, params are keyboard size and the keyboard notification
    public typealias KeyboardUpdateClosure = ((CGSize, NSNotification) -> Void)

    /**
    Subscribe to keyboard updates notifications.
    
    - parameter update: Closure called when keyboard change frame or hide. One can call self.adjustKeyboard with the notification.
    */
    public func observeKeyboardChanges(update: (NSNotification -> Void)) -> [NSObjectProtocol]
    {
        return NSNotificationCenter
            .defaultCenter()
            .addObserverWithNames([UIKeyboardWillChangeFrameNotification, UIKeyboardWillHideNotification], usingBlock: update)
    }
    
    /**
     Perform animation in the `update` closure with the same settings as the notification's animation settings.
     
     - parameter notification: UIKeyboardXXXXXNotification. Such as UIKeyboardWillChangeFrameNotification for example
     - parameter animate: Should animate the changes
     - parameter update: One should update constraints in this closure, the animation will run after it.
     */
    public func adjustWithKeyboard(notification n: NSNotification, animate: Bool, update: KeyboardUpdateClosure)
    {
        guard let userInfo = n.userInfo,
            keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().size,
            duration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue,
            curve = userInfo[UIKeyboardAnimationCurveUserInfoKey]?.unsignedIntValue
            else { return }
        
        update(keyboardSize, n)
        
        let options = UIViewAnimationOptions(rawValue: UInt(curve) << 16)
        
        if animate {
            UIView.animateWithDuration(duration, delay: 0, options: options, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
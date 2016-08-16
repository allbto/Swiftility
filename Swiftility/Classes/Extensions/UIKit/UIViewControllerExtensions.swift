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
    
    - parameter update: Closure called when keyboard change frame or hide. One can update constraints and then call self.animateWithKeyboard with the notification.
    */
    public func observeKeyboardChanges(update: KeyboardUpdateClosure) -> [NSObjectProtocol]
    {
        return NSNotificationCenter
            .defaultCenter()
            .addObserverWithNames([UIKeyboardWillChangeFrameNotification, UIKeyboardWillHideNotification]) { n in
                guard let
                    userInfo = n.userInfo,
                    keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().size
                    else { return }
                
                update(keyboardSize, n)
            }
    }
    
    /**
     Perform animations with the same settings as the notification's animation settings.
     Performs animations only if `notification` is a valid UIKeyboardXXXNotification.
     
     - parameter notification:  UIKeyboardXXXNotification. Such as UIKeyboardWillChangeFrameNotification for example
     - parameter animations:    Optional custom animations to perform. Default is { self.view.layoutIfNeeded() }
     - parameter completion:    Optional completion handler to animations
     */
    public func animateWithKeyboardNotification(notification: NSNotification,
                     animations: (() -> Void)? = nil,
                     completion: ((Bool) -> Void)? = nil)
    {
        guard let
            userInfo = notification.userInfo,
            duration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue,
            curve = userInfo[UIKeyboardAnimationCurveUserInfoKey]?.unsignedIntValue
            else { return }
        
        let options = UIViewAnimationOptions(rawValue: UInt(curve) << 16)
        
        UIView.animateWithDuration(
            duration,
            delay: 0,
            options: options,
            animations: {
                if let animations = animations {
                    animations()
                } else {
                    self.view.layoutIfNeeded()
                }
            },
            completion: completion
        )
    }
    
    /*
     
     Usage example:
     
     let observers = self.observeKeyboardChanges { [weak self] keyboardSize, n in

        self?.someConstraints.constant = keyboardSize.height
         
        self?.animateWithKeyboardNotification(n)
     }
     
     */
}
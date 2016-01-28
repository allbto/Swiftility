//
//  UIViewControllerExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/25/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit
import ObjectiveC
//import JGProgressHUD

var AssociatedObjectHandle: UInt8 = 0

extension UIViewController
{
    // MARK: - Alert
    
    public typealias UIAlertControllerButtonHandler = ((UIAlertAction) -> Void)
    public typealias UIAlertControllerCompletion = (() -> Void)
    
    public func alert(message: String, title: String? = nil, handler: UIAlertControllerButtonHandler? = nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: handler)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Keyboard
    
    /// Update closure, params are keyboard size and the keyboard notification
    public typealias KeyboardUpdateClosure = ((CGSize, NSNotification) -> Void)

    /**
    Subscribe to keyboard updates notifications.
    
    - parameter update: Closure called when keyboard change frame or hide. One should update constraints in this closure, the animation will run after the `update` closure
    */
    public func subscribeToKeyboardUpdates(animate animate: Bool = true, update: KeyboardUpdateClosure)
    {
        NSNotificationCenter.defaultCenter().addObserverWithNames([UIKeyboardWillChangeFrameNotification, UIKeyboardWillHideNotification]) { [weak self] n in
            
            self?._adjustKeyboardWithUpdateClosure(update, notification: n, animate: animate)
            
        }
    }
    
    private func _adjustKeyboardWithUpdateClosure(update: KeyboardUpdateClosure, notification n: NSNotification, animate: Bool)
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
    
    // MARK: - HUD
    
//    var defaultHUD: JGProgressHUD? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? JGProgressHUD
//        }
//        
//        set(val) {
//            objc_setAssociatedObject(self, &AssociatedObjectHandle, val, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//    
//    func showProgressHUD(title: String? = nil, style: JGProgressHUDStyle = .Light)
//    {
//        if defaultHUD == nil || defaultHUD!.style != style {
//            defaultHUD = JGProgressHUD(style: style)
//        }
//
//        defaultHUD!.textLabel.text = title
//        defaultHUD!.showInView(self.view)
//    }
//    
//    func hideProgressHUD(afterDelay: NSTimeInterval? = nil)
//    {
//        if let delay = afterDelay {
//            defaultHUD?.dismissAfterDelay(delay)
//        } else {
//            defaultHUD?.dismiss()
//        }
//    }
}
//
//  UIViewControllerExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/25/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
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
    
    /**
    Subscribe to keyboard updates notifications.
    Update constraint if != nil.
    Call updateClosure if != nil.
    If both == nil does nothing.
    
    - parameter constraint:    the contraint to update when keyboard change frame or hide
    - parameter updateClosure: called when keyboard change frame or hide
    */
    public func subscribeToKeyboardUpdates(constraint: NSLayoutConstraint?, updateClosure: ((NSNotification) -> Void)? = nil)
    {
        guard constraint != nil || updateClosure != nil else { return }
        
        NSNotificationCenter.defaultCenter().addObserverWithNames([UIKeyboardWillChangeFrameNotification, UIKeyboardWillHideNotification]) { [weak self] n in
            
            UIView.performWithoutAnimation({
                updateClosure?(n)
            })
            
            if let constraint = constraint {
                self?.adjustKeyboardContraint(constraint, notification: n)
            }
        }
    }
    
    private func adjustKeyboardContraint(constraint: NSLayoutConstraint, notification n: NSNotification)
    {
        guard let userInfo = n.userInfo,
            keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().size,
            duration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue,
            curve = userInfo[UIKeyboardAnimationCurveUserInfoKey]?.unsignedIntValue
            else { return }
        
        if n.name == UIKeyboardWillHideNotification {
            constraint.constant = 0
        } else {
            constraint.constant = keyboardSize.height
        }
        
        let options = UIViewAnimationOptions(rawValue: UInt(curve) << 16)
        
        UIView.animateWithDuration(duration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
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
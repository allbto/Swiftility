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
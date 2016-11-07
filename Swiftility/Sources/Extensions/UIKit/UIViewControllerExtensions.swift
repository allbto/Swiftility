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
    
    public func alert(_ message: String, title: String? = nil, handler: UIAlertControllerButtonHandler? = nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: handler)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func ask(_ message: String, title: String? = nil, actionTitle: String = "OK", action: UIAlertControllerButtonHandler? = nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: action)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Keyboard
extension UIViewController
{
    /// Update closure, params are keyboard size and the keyboard notification
    public typealias KeyboardUpdateClosure = ((CGSize, Notification) -> Void)

    /**
    Subscribe to keyboard updates notifications.
    
    - parameter update: Closure called when keyboard change frame or hide. One can update constraints and then call self.animateWithKeyboard with the notification.
    */
    public func observeKeyboardChanges(_ update: @escaping KeyboardUpdateClosure) -> [NSObjectProtocol]
    {
        return NotificationCenter
            .default
            .addObserver(withNames: [NSNotification.Name.UIKeyboardWillChangeFrame, NSNotification.Name.UIKeyboardWillHide]) { n in
                guard
                    let userInfo = n.userInfo,
                    let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
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
    public func animate(withKeyboardNotification notification: Notification,
                        animations: (() -> Void)? = nil,
                        completion: ((Bool) -> Void)? = nil)
    {
        guard
            let userInfo = notification.userInfo,
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let curve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uint32Value
            else { return }
        
        let options = UIViewAnimationOptions(rawValue: UInt(curve) << 16)
        
        UIView.animate(
            withDuration: duration,
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
         
        self?.animate(withKeyboardNotification: n)
     }
     
     */
}

// MARK: - Convenience setup
private var NotificationObserversKey: StaticString = "SW_NotificationObserversKey"
private var PermanentNotificationObserversKey: StaticString = "SW_PermanentNotificationObserversKey"
private var ViewHasLoadedObserversKey: StaticString = "SW_ViewHasLoadedObserversKey"
private var ViewHasAppearedObserversKey: StaticString = "SW_ViewHasAppearedObserversKey"

extension UIViewController
{
    // MARK: - Private Properties
    
    fileprivate var _notificationObservers: [NSObjectProtocol]? {
        get { return objc_getAssociatedObject(self, &NotificationObserversKey) as? [NSObjectProtocol] }
        set { objc_setAssociatedObject(self, &NotificationObserversKey, newValue as [NSObjectProtocol]?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    fileprivate var _permanentNotificationObservers: [NSObjectProtocol]? {
        get { return objc_getAssociatedObject(self, &PermanentNotificationObserversKey) as? [NSObjectProtocol] }
        set { objc_setAssociatedObject(self, &PermanentNotificationObserversKey, newValue as [NSObjectProtocol]?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Public Properties
    
    public fileprivate(set) var viewHasLoaded: Bool {
        get { return (objc_getAssociatedObject(self, &ViewHasLoadedObserversKey) as? Bool) ?? false }
        set { objc_setAssociatedObject(self, &ViewHasLoadedObserversKey, newValue as Bool?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    public fileprivate(set) var viewHasAppeared: Bool {
        get { return (objc_getAssociatedObject(self, &ViewHasAppearedObserversKey) as? Bool) ?? false }
        set { objc_setAssociatedObject(self, &ViewHasAppearedObserversKey, newValue as Bool?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Life cycle
    
    override open class func initialize()
    {
        guard self === UIViewController.self else { return }
        
        once(token: "com.swiftility.UIViewControllerInitialize") {
            swizzle(#selector(UIViewController.viewDidLoad), with: #selector(UIViewController.sw_viewDidLoad), on: self)
            
            swizzle(#selector(UIViewController.viewWillAppear(_:)), with: #selector(UIViewController.sw_viewWillAppear(_:)), on: self)
            swizzle(#selector(UIViewController.viewWillDisappear(_:)), with: #selector(UIViewController.sw_viewWillDisappear(_:)), on: self)
            
            swizzle(#selector(UIViewController.viewDidAppear(_:)), with: #selector(UIViewController.sw_viewDidAppear(_:)), on: self)
            swizzle(#selector(UIViewController.viewDidDisappear(_:)), with: #selector(UIViewController.sw_viewDidDisappear(_:)), on: self)
        }
    }
    
    func sw_viewDidLoad()
    {
        viewHasLoaded = true
        
        self.sw_viewDidLoad()
        
        self.sw_setupViews()
        
        let observers = self.sw_setupPermanentNotificationObservers()
        if !observers.isEmpty {
            _permanentNotificationObservers = observers
        }
    }
    
    func sw_viewWillAppear(_ animated: Bool)
    {
        self.sw_viewWillAppear(animated)
        
        let observers = self.sw_setupActiveNotificationObservers()
        if !observers.isEmpty {
            _notificationObservers = observers
        }
    }
    
    func sw_viewWillDisappear(_ animated: Bool)
    {
        self.sw_viewWillDisappear(animated)
        
        if let observers = _notificationObservers, !observers.isEmpty {
            NotificationCenter.default.removeObservers(observers)
        }
    }
    
    func sw_viewDidAppear(_ animated: Bool)
    {
        viewHasAppeared = true
        
        self.sw_viewDidAppear(animated)
    }
    
    func sw_viewDidDisappear(_ animated: Bool)
    {
        viewHasAppeared = false
        
        self.sw_viewDidDisappear(animated)
    }
    
    // MARK: - Open methods
    
    /// Notification observers setup when view appears and removed when view disappears
    open func sw_setupActiveNotificationObservers() -> [NSObjectProtocol]
    {
        return [] // To be overriden
    }
    
    /// Notification observers setup on view load and removed on deinit
    /// Don't forget to call self.sw_removePermanentObservers() on class deinit
    open func sw_setupPermanentNotificationObservers() -> [NSObjectProtocol]
    {
        return [] // To be overriden
    }
    
    open func sw_setupViews()
    {
        // To be overriden
    }
    
    // MARK: - Utils
    
    public func sw_removePermanentObservers()
    {
        if let observers = _permanentNotificationObservers, !observers.isEmpty {
            NotificationCenter.default.removeObservers(observers)
        }
    }
}

//
//  UIViewAutoLayoutExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 11/10/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension UIView
{
    // MARK: AutoLayout
    
    /// Adds `self` as subview to `superview`, removes autosizing mask constraints
    /// and calls constraints `builder` if needed
    ///
    /// Example usage:
    /// ```
    /// let label = UILabel()
    /// label.autoAttach(to: someView) {
    ///     $0.autoPin(.centerX)
    ///     $0.autoPin(.top, constant: 25)
    /// }
    /// ```
    ///
    /// - parameter superview:  Superview to attach to
    /// - parameter builder:    Optional constraints builder
    ///
    public func autoAttach(to superview: UIView, builder: ((_ view: UIView) -> Void)? = nil)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        builder?(self)
    }
    
    /// Creates a NSLayoutConstraint and adds it to `self.superview`.
    /// Simplifies creation of constraint by assinging default values.
    ///
    /// `self` must be contained within a superview.
    ///
    /// Examples:
    /// ```
    /// view.autoPin(.top)
    /// -> NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: view.superview!, attribute: .top, multiplier: 1, constant: 0)
    ///
    /// view.autoPin(.leading, toItem: someOtherView, toAttribute: .trailing, constant: 25)
    /// -> NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: someOtherView, attribute: .trailing, multiplier: 1, constant: 25)
    /// ```
    ///
    /// - parameter attribute:  First attribute (.top, .leading, ...)
    /// - parameter relatedBy:  Defaults to .equal
    /// - parameter toItem:     Second view. If not provided, defaults to superview. If nil, stays nil
    /// - parameter toAttribute:Second attribute. If (toItem: nil), defaults to .notAnAttribute. If nil, defaults to first attribute.
    /// - parameter multiplier: Defaults to 1
    /// - parameter constant:   Defaults to 0
    /// - parameter priority:   Defaults to UILayoutPriorityRequired
    ///
    /// - returns: Newly created constraint (discardable)
    @discardableResult
    public func autoPin(
        _ attribute: NSLayoutAttribute,
        relatedBy: NSLayoutRelation = .equal,
        toItem: Any? = false,
        toAttribute: NSLayoutAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint
    {
        guard let superview = self.superview else {
            sw_fatalError("View must be contained within a superview")
        }
        
        let toItem = toItem is Bool ? superview : toItem
        let toAttribute = toItem == nil ? .notAnAttribute : (toAttribute ?? attribute)
        
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        
        constraint.priority = priority
        
        superview.addConstraint(constraint)
        
        return constraint
    }

    // MARK: - Convenience

    /// Calls .autoPin for array of attributes
    ///
    /// Examples:
    /// ```
    /// view.autoPin([.top, .bottom])
    /// -> view.autoPin(.top)
    /// -> view.autoPin(.bottom)
    ///
    /// view.autoPin([.leading, .trailing], toItem: someOtherView, constant: 25)
    /// -> view.autoPin(.leading, toItem: someOtherView, constant: 25)
    /// -> view.autoPin(.trailing, toItem: someOtherView, constant: 25)
    /// ```
    ///
    /// - parameter attributes: Array of attributes
    /// - parameter relatedBy:  Defaults to .equal
    /// - parameter toItem:     Second view. If not provided, defaults to superview. If nil, stays nil
    /// - parameter multiplier: Defaults to 1
    /// - parameter constant:   Defaults to 0
    ///
    /// - returns: Newly created constraints (discardable)
    @discardableResult
    public func autoPin(
        _ attributes: [NSLayoutAttribute],
        relatedBy: NSLayoutRelation = .equal,
        toItem: Any? = false,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0) -> [NSLayoutConstraint]
    {
        var constraints = [NSLayoutConstraint]()
        
        for attribute in attributes {
            constraints.append(self.autoPin(attribute, relatedBy: relatedBy, toItem: toItem, multiplier: multiplier, constant: constant))
        }
        
        return constraints
    }
    
    /// Calls .autoPin for .top, .trailing, .bottom, .leading constraints
    ///
    /// - parameter edges:      Edges to item
    /// - parameter toItem:     Second view. If not provided, defaults to superview. If nil, stays nil
    ///
    /// - returns: Newly created constraints (discardable)
    @discardableResult
    public func autoPinEdges(
        _ edges: UIEdgeInsets = .zero,
        toItem: Any? = false) -> [NSLayoutConstraint]
    {
        return [
            self.autoPin(.top, toItem: toItem, constant: edges.top),
            self.autoPin(.trailing, toItem: toItem, constant: -edges.right),
            self.autoPin(.bottom, toItem: toItem, constant: -edges.bottom),
            self.autoPin(.leading, toItem: toItem, constant: edges.left),
        ]
    }
    
    /// Calls .autoAttach and sets .top, .trailing, .bottom, .leading constraints
    ///
    /// - parameter superview:  Superview to attach to
    /// - parameter edges:      Edges to item
    public func autoAttachAndPinEdges(to superview: UIView, edges: UIEdgeInsets = .zero)
    {
        self.autoAttach(to: superview) {
            $0.autoPinEdges(edges)
        }
    }
    
    /// Calls .autoPin for .centerX, .centerY constraints
    ///
    /// - parameter toItem:     Second view. If not provided, defaults to superview. If nil, stays nil
    ///
    /// - returns: Newly created constraints (discardable)
    @discardableResult
    public func autoPinCenter(toItem: Any? = false) -> [NSLayoutConstraint]
    {
        return [
            self.autoPin(.centerX, toItem: toItem),
            self.autoPin(.centerY, toItem: toItem),
        ]
    }
    
    /// Calls .autoAttach and sets .centerX, .centerY constraints
    ///
    /// - parameter superview:  Superview to attach to
    public func autoAttachAndCenter(in superview: UIView)
    {
        self.autoAttach(to: superview) {
            $0.autoPinCenter()
        }
    }
}

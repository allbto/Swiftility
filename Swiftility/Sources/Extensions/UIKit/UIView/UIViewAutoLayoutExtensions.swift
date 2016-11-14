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
    
    /// Adds self as subview to superview, remove autosizing mask constraint
    /// and calls constraints builder
    ///
    /// Example usage:
    /// let label = UILabel()
    /// label.autoAttach(to: someView) {
    ///     $0.autoPin(.centerX)
    ///     $0.autoPin(.top, constant: 25)
    /// }
    public func autoAttach(to superview: UIView, builder: (_ view: UIView) -> Void)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        builder(self)
    }
    
    /// Creates constraint and add it to the superview
    /// Simplifies creation of NSLayoutConstraint by assinging default values
    ///
    /// Examples:
    /// view.autoPin(.top)
    /// -> NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: view.superview!, attribute: .top, multiplier: 1, constant: 0)
    ///
    /// view.autoPin(.leading, toItem: someOtherView, toAttribute: .trailing, constant: 25)
    /// -> NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: someOtherView, attribute: .trailing, multiplier: 1, constant: 25)
    ///
    /// - parameter attribute:  first attribute (.top, .leading, ...)
    /// - parameter relatedBy:  relation. Defaults to .equal
    /// - parameter toItem:     second view. If not provided, defaults to superview, if nil stays nil
    /// - parameter toAttribute:second attribute. If (toItem: nil), defaults to .notAnAttribute. If nil defaults to first attribute.
    /// - parameter multiplier: Defaults to 1
    /// - parameter constant:   Defaults to 0
    /// - parameter priority:   Defaults to UILayoutPriorityRequired
    ///
    /// - returns: Newly created constraint (discardable)
    @discardableResult
    public func autoPin(
        _ attribute: NSLayoutAttribute,
        relatedBy relation: NSLayoutRelation = .equal,
        toItem view2: Any? = false,
        toAttribute attr2: NSLayoutAttribute? = nil,
        multiplier: CGFloat = 1,
        constant c: CGFloat = 0,
        priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint
    {
        guard let superview = self.superview else {
            sw_fatalError("Must be added to a superview")
        }
        
        let view2 = view2 is Bool ? superview : view2
        let attr2 = view2 == nil ? .notAnAttribute : (attr2 ?? attribute)
        
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relation, toItem: view2, attribute: attr2, multiplier: multiplier, constant: c)
        
        constraint.priority = priority
        
        superview.addConstraint(constraint)
        
        return constraint
    }

    // MARK: - Convenience

    /// Calls .autoPin for array of attributes
    ///
    /// Examples:
    /// view.autoPin([.top, .bottom])
    /// -> view.autoPin(.top)
    /// -> view.autoPin(.bottom)
    ///
    /// view.autoPin([.leading, .trailing], toItem: someOtherView, constant: 25)
    /// -> view.autoPin(.leading, toItem: someOtherView, constant: 25)
    /// -> view.autoPin(.trailing, toItem: someOtherView, constant: 25)
    ///
    /// - parameter attributes: Array of attributes
    /// - parameter relatedBy:  relation. Defaults to .equal
    /// - parameter toItem:     second view. If not provided, defaults to superview, if nil stays nil
    /// - parameter multiplier: Defaults to 1
    /// - parameter constant:   Defaults to 0
    ///
    /// - returns: Newly created constraints (discardable)
    @discardableResult
    public func autoPin(
        _ attributes: [NSLayoutAttribute],
        relatedBy relation: NSLayoutRelation = .equal,
        toItem view2: Any? = false,
        multiplier: CGFloat = 1,
        constant c: CGFloat = 0) -> [NSLayoutConstraint]
    {
        var constraints = [NSLayoutConstraint]()
        
        for attribute in attributes {
            constraints.append(self.autoPin(attribute, relatedBy: relation, toItem: view2, multiplier: multiplier, constant: c))
        }
        
        return constraints
    }
    
    /// Calls .autoPin for .top, .trailing, .bottom, .leading constraints
    ///
    /// - parameter edges:      Edges to item
    /// - parameter toItem:     second view. If not provided, defaults to superview, if nil stays nil
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
    public func autoAttachAndPinEdges(to superview: UIView, edges: UIEdgeInsets = .zero)
    {
        self.autoAttach(to: superview) {
            $0.autoPinEdges(edges)
        }
    }
}

//
//  UITableView.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/29/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

public protocol TableViewCell
{
    static var DefaultHeight: CGFloat { get }
}

extension TableViewCell
{
    public static var DefaultHeight: CGFloat { return 44 }
}

extension UITableView
{
    public func registerCell<T where T: UITableViewCell, T: FromNib>(type: T.Type)
    {
        self.registerNib(type.nib.nib, forCellReuseIdentifier: String(type))
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T
    {
        guard let cell = self.dequeueReusableCellWithIdentifier(String(type)) as? T else {
            fatalError("\(String(type)) cell could not be instantiated because it was not found on the tableView(\(self))")
        }
        
        return cell
    }
}
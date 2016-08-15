//
//  UITableView.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/29/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

public protocol TableViewCell: FromNib
{
    static var DefaultHeight: CGFloat { get }
}

extension TableViewCell
{
    public static var DefaultHeight: CGFloat { return 44 }
}

extension UITableView
{
    // MARK: - Register
    
    public func registerCell<T where T: UITableViewCell, T: FromNib>(type: T.Type)
    {
        self.registerNib(type.ownNib.nib, forCellReuseIdentifier: String(type))
    }
    
    public func registerClass<T: UITableViewCell>(type: T.Type)
    {
        self.registerClass(T.self, forCellReuseIdentifier: String(T))
    }
    
    // MARK: - Dequeue
    
    public func dequeueReusableCell<T: UITableViewCell>() -> T
    {
        guard let cell = self.dequeueReusableCellWithIdentifier(String(T)) as? T else {
            fatalError("\(String(T)) cell could not be instantiated because it was not found on the tableView(\(self))")
        }
        
        return cell
    }

    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: NSIndexPath) -> T
    {
        guard let cell = self.dequeueReusableCellWithIdentifier(String(T), forIndexPath: indexPath) as? T else {
            fatalError("\(String(T)) cell could not be instantiated because it was not found on the tableView(\(self))")
        }
        
        return cell
    }
}

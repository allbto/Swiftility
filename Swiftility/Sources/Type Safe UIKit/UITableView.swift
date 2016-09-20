//
//  UITableView.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/29/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension UITableViewCell
{
    public class var DefaultHeight: CGFloat { return 44 }
}

extension UITableView
{
    // MARK: - Register
    
    public func register<T>(_ type: T.Type) where T: UITableViewCell, T: FromNib
    {
        self.register(type.ownNib.nib, forCellReuseIdentifier: String(describing: type))
    }
    
    public func register<T: UITableViewCell>(_ type: T.Type)
    {
        self.register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    // MARK: - Dequeue
    
    public func dequeueReusableCell<T: UITableViewCell>() -> T
    {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("\(String(describing: T.self)) cell could not be instantiated because it was not found on the tableView(\(self))")
        }
        
        return cell
    }

    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T
    {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("\(String(describing: T.self)) cell could not be instantiated because it was not found on the tableView(\(self))")
        }
        
        return cell
    }
}

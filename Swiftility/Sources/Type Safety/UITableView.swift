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
    open class var defaultHeight: CGFloat { return 44 }
}

extension UITableView
{
    // MARK: - Register
    
    public func register<T>(_ nibCell: T.Type) where T: UITableViewCell, T: FromNib
    {
        self.register(nibCell.ownNib.nib, forCellReuseIdentifier: String(describing: nibCell))
    }
    
    public func register<T: UITableViewCell>(_ classCell: T.Type)
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
        var cell: UITableViewCell? = nil
        
        do {
            try ObjC.catchException {
                cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath)
            }
        } catch {
            cell = nil
        }
        
        guard let typedCell = cell as? T else {
            fatalError("\(String(describing: T.self)) cell could not be instantiated because it was not found on the tableView(\(self))")
        }
        
        return typedCell
    }
}

//
//  ModelViewViewModel.swift
//  PuraScents
//
//  Created by Allan Barbato on 10/21/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import Foundation

public protocol FromStoryboard
{
    static var storyboard: String { get }
}

extension FromStoryboard
{
    public static var uiStoryboard: UIStoryboard {
        return UIStoryboard(name: Self.storyboard, bundle: nil)
    }
}

public protocol ViewController: FromStoryboard
{
    typealias VM
    var viewModel: VM! { get set }
}

extension UIStoryboard
{
    
    public func instantiateViewController<T where T: UIViewController, T: ViewController>(type: T.Type, vm: T.VM) -> T
    {
        var vc = self.instantiateViewController(type)

        vc.viewModel = vm
        
        return vc
    }

    public func instantiateViewController<T where T: UIViewController>(type: T.Type) -> T
    {
        guard let vc = self.silentlyInstantiateViewControllerWithIdentifier(String(type)) as? T else {
            fatalError("\(String(type)) could not be instanciated because it was not found in storyboard: \(self)")
        }
        
        return vc
    }

}

extension UIViewController
{
    
    public func instantiateViewController<T where T: UIViewController, T: ViewController>(type: T.Type, vm: T.VM, storyboard: String? = T.storyboard) -> T
    {
        var vc = self.instantiateViewController(type, storyboard: storyboard)
        
        vc.viewModel = vm
        return vc
    }
    
    public func instantiateViewController<T where T: UIViewController, T: FromStoryboard>(type: T.Type, storyboard: String? = T.storyboard) -> T
    {
        let storyboardContainer: UIStoryboard
        
        if let storyboard = storyboard {
            storyboardContainer = UIStoryboard(name: storyboard, bundle: nil)
        } else if let storyboard = self.storyboard {
            storyboardContainer = storyboard
        } else {
            fatalError("No storyboard name provided and the view controller doesn't contain storyboard name")
        }
        
        return storyboardContainer.instantiateViewController(type)
    }
    
}

extension UIView
{
    
    public class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T
    {
        guard let view = NSBundle.mainBundle().loadNibNamed(String(viewType), owner: nil, options: nil).first as? T else {
            fatalError("\(String(viewType)) could not be instanciated because it was not found main bundle or the nib did not contain \(String(viewType))")
        }
        
        return view
    }

    public func instantiateFromNib<T: UIView>(viewType: T.Type) -> T
    {
        return UIView.instantiateFromNib(viewType)
    }
    
}

public protocol TableViewCell
{
    static var Height: CGFloat { get }
}

extension UITableView
{
    public func dequeueReusableCell<T where T: UITableViewCell, T: TableViewCell>(type: T.Type) -> T
    {
        guard let cell = self.dequeueReusableCellWithIdentifier(String(type)) as? T else {
            fatalError("\(String(type)) cell could not be instanciated because it was not found on the tableView")
        }
        
        return cell
    }
}

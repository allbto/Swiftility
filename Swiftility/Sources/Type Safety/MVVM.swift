//
//  MVVM.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/29/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

public protocol ViewModelController
{
    associatedtype VM
    var viewModel: VM! { get set }
}

extension ViewModelController where Self: UIViewController
{
    public init(viewModel: Self.VM)
    {
        self.init()
        
        self.viewModel = viewModel
    }
}

extension FromStoryboard where Self: UIViewController, Self: ViewModelController
{
    public static func instantiateFromStoryboard(viewModel: Self.VM) -> Self
    {
        return  UIStoryboard(name: self.storyboardName).instantiateViewController(Self.self, vm: viewModel)
    }
}

extension UIStoryboard
{
    public func instantiateViewController<T>(_ type: T.Type, vm: T.VM) -> T where T: UIViewController, T: ViewModelController
    {
        var vc: T = self.instantiateViewController()
        
        vc.viewModel = vm
        
        return vc
    }
}

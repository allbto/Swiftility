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

extension FromStoryboard where Self: UIViewController, Self: ViewModelController
{
    public static func instantiateFromStoryboard(viewModel viewModel: Self.VM) -> Self
    {
        return self.ownStoryboard.storyboard.instantiateViewController(Self.self, vm: viewModel)
    }
}

extension UIStoryboard
{
    public func instantiateViewController<T where T: UIViewController, T: ViewModelController>(type: T.Type, vm: T.VM) -> T
    {
        var vc: T = self.instantiateViewController()
        
        vc.viewModel = vm
        
        return vc
    }
}
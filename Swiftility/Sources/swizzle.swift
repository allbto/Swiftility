//
//  swizzle.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/26/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

public func swizzle(_ originalSelector: Selector, with swizzleSelector: Selector, on object: AnyClass)
{
    let originalMethod = class_getInstanceMethod(object, originalSelector)
    let swizzleMethod = class_getInstanceMethod(object, swizzleSelector)
    
    if class_addMethod(object, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod)) {
        class_replaceMethod(object, swizzleSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod)
    }
}
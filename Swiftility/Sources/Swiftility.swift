//
//  Swiftility.swift
//  Swiftility
//
//  Created by Allan BARBATO on 20/09/2017.
//  Copyright © 2017 Allan Barbato. All rights reserved.
//

import UIKit

public enum Swiftility {
    
    public static func initialize() {
        UIViewController._setupSwizzle()
    }
    
}

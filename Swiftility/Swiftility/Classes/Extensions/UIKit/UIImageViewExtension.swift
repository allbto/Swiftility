//
//  UIImageViewExtentions.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/18/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit

extension UIImageView
{
    public func setImage(image: UIImage?, withColor color: UIColor)
    {
        self.image = image?.imageWithRenderingMode(.AlwaysTemplate)
        self.tintColor = color
    }
}
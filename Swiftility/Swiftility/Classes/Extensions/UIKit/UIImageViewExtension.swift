//
//  UIImageViewExtentions.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/18/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import UIKit

extension UIImageView
{
    func setImage(image: UIImage?, withColor color: UIColor)
    {
        self.image = image?.imageWithRenderingMode(.AlwaysTemplate)
        self.tintColor = color
    }
}
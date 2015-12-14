//
//  UIPageViewControllerExtensions.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/16/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import UIKit

extension UIPageViewController
{
    var scrollView: UIScrollView? {
        for view in self.view.subviews {
            if let scrollView = view as? UIScrollView {
                return scrollView
            }
        }
        
        return nil
    }
}
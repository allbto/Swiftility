//
//  UIScrollViewExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/18/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension UIScrollView
{
    /**
     Horizontaly scroll rect to given page
     TODO: Verification of frame
     
     - parameter page:     To scroll to
     - parameter animated: Show animation
     */
    public func scrollToPage(page: Int, animated: Bool)
    {
        var frame = self.frame
        
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        
        self.scrollRectToVisible(frame, animated:animated)
    }
    
    /// Get or Set animated the current horizontal page
    public var currentPage: Int {
        get {
            let pageWidth = self.frame.size.width
            let fractionalPage = self.contentOffset.x / pageWidth
            
            return lround(Double(fractionalPage))
        }
        
        set {
            self.scrollToPage(newValue, animated: true)
        }
    }
}
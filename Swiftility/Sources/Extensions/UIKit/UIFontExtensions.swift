//
//  UIFontExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/8/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension UIFont
{
    /**
    Prints all the fonts available
    
    - parameter filter: Optional filter on the family name of the fonts
    */
    public static func printAllFonts(familyFilter filter: String? = nil)
    {
        print("\n--- FONTS\((filter != nil) ? " familyFilter=\(filter!)" : "") ---\n")
        
        UIFont.familyNames.forEach { name in
            guard filter == nil || name.contains(filter!) else { return }
            
            print(name)
            
            UIFont.fontNames(forFamilyName: name).forEach { font in
                print("   \(font)")
            }
        }
        
        print("\n--- END FONTS ---\n")
    }
}

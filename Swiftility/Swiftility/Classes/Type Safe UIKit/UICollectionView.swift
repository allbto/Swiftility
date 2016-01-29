//
//  UICollectionView.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/29/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension UICollectionView
{
    public func dequeueReusableCell<T where T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: NSIndexPath) -> T
    {
        guard let cell = self.dequeueReusableCellWithReuseIdentifier(String(type), forIndexPath: indexPath) as? T else {
            fatalError("\(String(type)) cell could not be instantiated because it was not found on the collectionView(\(self))")
        }
        
        return cell
    }
    
    public func dequeueReusableSupplementaryView<T where T: UICollectionReusableView>(kind elementKind: String, type: T.Type, forIndexPath indexPath: NSIndexPath) -> T
    {
        guard let view = self.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: String(type), forIndexPath: indexPath) as? T else {
            fatalError("\(String(type)) supplementary view of kind \(elementKind) could not be instantiated because it was not found on the collectionView(\(self))")
        }
        
        return view
    }
}
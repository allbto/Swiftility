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
    public func registerCell<T where T: UICollectionViewCell, T: FromNib>(type: T.Type)
    {
        self.registerNib(type.ownNib.nib, forCellWithReuseIdentifier: type.ownNib.nibName)
    }
    
    public func registerSupplementaryView<T where T: UICollectionReusableView, T: FromNib>(type: T.Type, forSupplementaryViewOfKind elementKind: String)
    {
        self.registerNib(type.ownNib.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: type.ownNib.nibName)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: NSIndexPath) -> T
    {
        guard let cell = self.dequeueReusableCellWithReuseIdentifier(String(T), forIndexPath: indexPath) as? T else {
            fatalError("\(String(T)) cell could not be instantiated because it was not found on the collectionView(\(self))")
        }
        
        return cell
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(kind elementKind: String, forIndexPath indexPath: NSIndexPath) -> T
    {
        guard let view = self.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: String(T), forIndexPath: indexPath) as? T else {
            fatalError("\(String(T)) supplementary view of kind \(elementKind) could not be instantiated because it was not found on the collectionView(\(self))")
        }
        
        return view
    }
}

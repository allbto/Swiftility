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
    // MARK: - Cell
    
    public func register<T>(_ type: T.Type) where T: UICollectionViewCell, T: FromNib
    {
        self.register(type.ownNib.nib, forCellWithReuseIdentifier: type.ownNib.nibName)
    }
    
    public func register<T: UICollectionViewCell>(_ type: T.Type)
    {
        self.register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    // MARK: - Supplementary view
    
    public func register<T>(_ type: T.Type, forSupplementaryViewOfKind elementKind: String) where T: UICollectionReusableView, T: FromNib
    {
        self.register(type.ownNib.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: type.ownNib.nibName)
    }

    public func register<T: UICollectionReusableView>(_ type: T.Type, forSupplementaryViewOfKind elementKind: String)
    {
        self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: String(describing: T.self))
    }
    
    // MARK: - Dequeue 
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T
    {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("\(String(describing: T.self)) cell could not be instantiated because it was not found on the collectionView(\(self))")
        }
        
        return cell
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> T
    {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("\(String(describing: T.self)) supplementary view of kind \(elementKind) could not be instantiated because it was not found on the collectionView(\(self))")
        }
        
        return view
    }
}

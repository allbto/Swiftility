//
//  UICollectionViewExtensions.swift
//  Swiftility
//
//  Created by Allan Barbato on 6/7/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

extension UICollectionView
{
    public var flowLayout: UICollectionViewFlowLayout {
        guard let layout = self.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("\(self) view layout must be of type UICollectionViewFlowLayout")
        }
        
        return layout
    }
    
    public func targetCenteredContentOffset(proposedContentOffset offset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint
    {
        let cvBounds = self.bounds
        let halfWidth = cvBounds.size.width * 0.5
        let proposedContentOffsetCenterX = offset.x + halfWidth
        
        guard let attributesForVisibleCells = self.collectionViewLayout.layoutAttributesForElements(in: cvBounds) else { return offset }
        
        var candidateAttributes: UICollectionViewLayoutAttributes?
        
        for attributes in attributesForVisibleCells {
            
            guard let candAttrs = candidateAttributes else {
                candidateAttributes = attributes
                continue
            }
            
            let a = attributes.center.x - proposedContentOffsetCenterX
            let b = candAttrs.center.x - proposedContentOffsetCenterX
            
            if fabsf(Float(a)) < fabsf(Float(b)) {
                candidateAttributes = attributes
            }
        }
        
        return CGPoint(x: round(candidateAttributes!.center.x - halfWidth), y: offset.y)
    }
}

extension UICollectionView
{
    public func indexPathForItemAtCenter() -> IndexPath?
    {
        let point = CGPoint(
            x: self.center.x + self.contentOffset.x,
            y: self.center.y + self.contentOffset.y
        )
        
        return self.indexPathForItem(at: point)
    }
}

//
//  UIImageEffectsExtension.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/22/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import UIKit

extension UIImage
{
    public func applyingLightEffect() -> UIImage?
    {
        return UIImageEffects.imageByApplyingLightEffect(to: self)
    }

    public func applyingExtraLightEffect() -> UIImage?
    {
        return UIImageEffects.imageByApplyingExtraLightEffect(to: self)
    }

    public func applyingDarkEffect() -> UIImage?
    {
        return UIImageEffects.imageByApplyingDarkEffect(to: self)
    }

    public func applyingTintEffect(with color: UIColor) -> UIImage?
    {
        return UIImageEffects.imageByApplyingTintEffect(with: color, to: self)
    }

    public func applyingBlur(withRadius radius: CGFloat, tintColor: UIColor? = nil, saturationDeltaFactor: CGFloat = 1.8, maskImage: UIImage? = nil) -> UIImage?
    {
        return UIImageEffects.imageByApplyingBlur(to: self, withRadius: radius, tintColor: tintColor, saturationDeltaFactor: saturationDeltaFactor, maskImage: maskImage)
    }
}

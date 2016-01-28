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
    public func applyLightEffect() -> UIImage?
    {
        return UIImageEffects.imageByApplyingLightEffectToImage(self)
    }

    public func applyExtraLightEffect() -> UIImage?
    {
        return UIImageEffects.imageByApplyingExtraLightEffectToImage(self)
    }

    public func applyDarkEffect() -> UIImage?
    {
        return UIImageEffects.imageByApplyingDarkEffectToImage(self)
    }

    public func applyTintEffectWithColor(color: UIColor) -> UIImage?
    {
        return UIImageEffects.imageByApplyingTintEffectWithColor(color, toImage: self)
    }

    public func applyBlurWithRadius(radius: CGFloat, tintColor: UIColor? = nil, saturationDeltaFactor: CGFloat = 1.8, maskImage: UIImage? = nil) -> UIImage?
    {
        return UIImageEffects.imageByApplyingBlurToImage(self, withRadius: radius, tintColor: tintColor, saturationDeltaFactor: saturationDeltaFactor, maskImage: maskImage)
    }
}
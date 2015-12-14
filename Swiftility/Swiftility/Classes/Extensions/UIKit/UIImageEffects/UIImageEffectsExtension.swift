//
//  UIImageEffectsExtension.swift
//  PuraScents
//
//  Created by Allan Barbato on 9/22/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

import UIKit

extension UIImage
{
    func applyLightEffect() -> UIImage?
    {
        return UIImageEffects.imageByApplyingLightEffectToImage(self)
    }

    func applyExtraLightEffect() -> UIImage?
    {
        return UIImageEffects.imageByApplyingExtraLightEffectToImage(self)
    }

    func applyDarkEffect() -> UIImage?
    {
        return UIImageEffects.imageByApplyingDarkEffectToImage(self)
    }

    func applyTintEffectWithColor(color: UIColor) -> UIImage?
    {
        return UIImageEffects.imageByApplyingTintEffectWithColor(color, toImage: self)
    }

    func applyBlurWithRadius(radius: CGFloat, tintColor: UIColor? = nil, saturationDeltaFactor: CGFloat = 1.8, maskImage: UIImage? = nil) -> UIImage?
    {
        return UIImageEffects.imageByApplyingBlurToImage(self, withRadius: radius, tintColor: tintColor, saturationDeltaFactor: saturationDeltaFactor, maskImage: maskImage)
    }
}
//
//  UIView+Extensions.m
//  PuraScents
//
//  Created by Allan Barbato on 10/14/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

+ (instancetype)appearanceWhenContainedInClass:(Class<UIAppearanceContainer>)ContainerClass
{
    return [self appearanceWhenContainedIn:ContainerClass, nil];
}

@end

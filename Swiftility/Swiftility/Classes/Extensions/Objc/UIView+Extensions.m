//
//  UIView+Extensions.m
//  Swiftility
//
//  Created by Allan Barbato on 10/14/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

+ (instancetype)appearanceWhenContainedInClass:(Class<UIAppearanceContainer>)ContainerClass
{
    return [self appearanceWhenContainedIn:ContainerClass, nil];
}

@end

//
//  UIView+Extensions.m
//  Swiftility
//
//  Created by Allan Barbato on 10/14/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

+ (nonnull instancetype)appearanceWhenContainedInClass:(nonnull Class<UIAppearanceContainer>)containerClass;
{
    return [self appearanceWhenContainedIn:containerClass, nil];
}

@end

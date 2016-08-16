//
//  UIView+Extensions.h
//  Swiftility
//
//  Created by Allan Barbato on 10/14/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)

+ (nonnull instancetype)appearanceWhenContainedInClass:(nonnull Class<UIAppearanceContainer>)ContainerClass;

@end

//
//  UIStoryboard+Extensions.m
//  Swiftility
//
//  Created by Allan Barbato on 10/21/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

#import "UIStoryboard+Extensions.h"

@implementation UIStoryboard (Extensions)

- (nullable __kindof UIViewController *)silentlyInstantiateViewControllerWithIdentifier:(nonnull NSString *)identifier;
{
    UIViewController *controller = nil;
    
    @try {
        controller = [self instantiateViewControllerWithIdentifier:identifier];
    }
    @catch (NSException *exception) {
        return nil;
    }
    
    return controller;
}


@end

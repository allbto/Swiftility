//
//  UIStoryboard+Extensions.h
//  PuraScents
//
//  Created by Allan Barbato on 10/21/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Extensions)

- (nullable __kindof UIViewController *)silentlyInstantiateViewControllerWithIdentifier:(nonnull NSString *)identifier;

@end

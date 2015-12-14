//
//  CALayer+Extensions.m
//  PuraScents
//
//  Created by Allan Barbato on 10/16/15.
//  Copyright © 2015 Pura Scents. All rights reserved.
//

#import "CALayer+Extensions.h"

@implementation CALayer (Extensions)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end

//
//  ObjC.m
//  Swiftility
//
//  Created by Allan Barbato on 9/21/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

#import "ObjC.h"

@implementation ObjC
    
+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error
{
    @try {
        tryBlock();
        return YES;
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
    }
}

@end

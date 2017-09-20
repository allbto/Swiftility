//
//  ObjC.h
//  Swiftility
//
//  Created by Allan Barbato on 9/21/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjC : NSObject

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end

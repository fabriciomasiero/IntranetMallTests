//
//  NSDictionary+Extras.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 22/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "NSDictionary+Extras.h"

@implementation NSDictionary (Extras)

- (BOOL)containsKey:(NSString *)key {
    if ([self objectForKey:key]) {
        return YES;
    } else {
        return NO;
    }
}

@end

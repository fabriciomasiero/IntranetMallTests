//
//  AFMenuItem.m
//  TaxiCustomer
//
//  Created by Ricardo Ramos on 29/04/15.
//  Copyright (c) 2015 AppFactory. All rights reserved.
//

#import "AFMenuItem.h"

@implementation AFMenuItem

#pragma mark - NSObject

+ (instancetype)itemWithTitle:(NSString *)title icon:(UIImage *)icon tag:(NSInteger)tag {
    return [[AFMenuItem alloc] initWithTitle:title icon:icon tag:tag];
}

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon tag:(NSInteger)tag {
    self = [super init];
    if (self) {
        _title = title;
        _icon = icon;
        _tag = tag;
    }
    return self;
}

@end

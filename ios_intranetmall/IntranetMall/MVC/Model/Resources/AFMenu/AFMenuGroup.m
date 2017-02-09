//
//  AFMenuGroup.m
//  TaxiCustomer
//
//  Created by Ricardo Ramos on 29/04/15.
//  Copyright (c) 2015 AppFactory. All rights reserved.
//

#import "AFMenuGroup.h"
#import "AFMenuItem.h"

@interface AFMenuGroup () {
    NSMutableArray *_menuItems;
}

@end

@implementation AFMenuGroup

#pragma mark - NSObject

+ (instancetype)groupWithTitle:(NSString *)title {
    return [[AFMenuGroup alloc] initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [self init];
    if (self) {
        _title = title;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _menuItems = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (AFMenuItem *)addItemWithTitle:(NSString *)title icon:(UIImage *)icon tag:(NSInteger)tag {
    AFMenuItem *item = [AFMenuItem itemWithTitle:title icon:icon tag:tag];
    
    [_menuItems addObject:item];
    
    return item;
}

- (void)clearItems {
    [_menuItems removeAllObjects];
}

#pragma mark - Properties

- (NSArray *)menuItems {
    return [NSArray arrayWithArray:_menuItems];
}

- (void)setMenuItems:(NSArray *)menuItems {
    _menuItems = [[NSMutableArray alloc] initWithArray:menuItems];
}

@end

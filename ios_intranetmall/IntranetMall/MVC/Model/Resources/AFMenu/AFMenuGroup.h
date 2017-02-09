//
//  AFMenuGroup.h
//  TaxiCustomer
//
//  Created by Ricardo Ramos on 29/04/15.
//  Copyright (c) 2015 AppFactory. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFMenuItem;

@interface AFMenuGroup : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *menuItems;

+ (instancetype)groupWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title;
- (AFMenuItem *)addItemWithTitle:(NSString *)title icon:(UIImage *)icon tag:(NSInteger)tag;

- (void)clearItems;

@end

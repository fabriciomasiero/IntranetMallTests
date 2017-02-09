//
//  AFMenuItem.h
//  TaxiCustomer
//
//  Created by Ricardo Ramos on 29/04/15.
//  Copyright (c) 2015 AppFactory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFMenuItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *icon;
@property (assign, nonatomic) NSInteger tag;

+ (instancetype)itemWithTitle:(NSString *)title icon:(UIImage *)icon tag:(NSInteger)tag;
- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon tag:(NSInteger)tag;

@end

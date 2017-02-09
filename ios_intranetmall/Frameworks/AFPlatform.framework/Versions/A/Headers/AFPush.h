//
//  AFPush.h
//  PoderosoCastiga
//
//  Created by Ricardo Ramos on 1/24/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFPush : NSObject

@property (readonly, nonatomic) NSString *deviceToken;

+ (instancetype)shared;

- (void)registerDeviceToken:(NSData *)token;
- (void)registerDeviceToken:(NSData *)token success:(void (^)())success failure:(void (^)(NSError *error))failure;

@end

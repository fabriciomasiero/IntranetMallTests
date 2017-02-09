//
//  AFDevice.h
//  PoderosoCastiga
//
//  Created by Ricardo Ramos on 1/24/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AFDeviceType) {
    AFDeviceTypeiOS = 1,
    AFDeviceTypeAndroid = 2
};

@interface AFDevice : NSObject

@property (readonly, nonatomic) NSInteger deviceID;
@property (readonly, nonatomic) NSString *uniqueIdentifier;
@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *modelName;
@property (readonly, nonatomic) NSString *systemName;
@property (readonly, nonatomic) NSString *systemVersion;
@property (readonly, nonatomic) AFDeviceType deviceType;
@property (readonly, nonatomic) NSString *pushToken;
@property (readonly, nonatomic) NSString *amazonEndpointArn;
@property (readonly, nonatomic) BOOL registered;

+ (instancetype)currentDevice;
+ (void)registerForNotifications;

- (void)registerDevice;
- (void)registerDeviceWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;

- (void)registerPushToken:(NSString *)pushToken;
- (void)registerPushToken:(NSString *)pushToken success:(void (^)())success failure:(void (^)(NSError *error))failure;

- (void)unregisterPushToken;
- (void)unregisterPushTokenWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;

@end

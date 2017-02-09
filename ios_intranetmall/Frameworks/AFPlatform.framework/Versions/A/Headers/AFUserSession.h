//
//  AFUserSession.h
//  Alsco
//
//  Created by Ricardo Ramos on 2/18/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AFUserSessionType) {
    AFUserSessionTypeNone,
    AFUserSessionTypeCMSUser,
    AFUserSessionTypeApplicationUser
};

extern NSString * const AFUserSessionDidStartNotification;
extern NSString * const AFUserSessionDidFinishNotification;

@class AFApplicationUser;

@interface AFUserSession : NSObject

@property (assign, nonatomic) AFUserSessionType sessionType;
@property (strong, nonatomic) AFApplicationUser *loggedUser;
@property (readonly, nonatomic) NSString *registeredDeviceToken;
@property (assign, nonatomic) BOOL disablePushNotificationRegistrationOnSessionStarted;

+ (instancetype)shared;
+ (BOOL)sessionStarted;

- (id)initWithLoggedUser:(AFApplicationUser *)loggedUser;
- (void)startSessionWithApplicationUser:(AFApplicationUser *)user success:(void (^)())success failure:(void (^)(NSError *error))failure;
- (void)startSessionWithApplicationUser:(AFApplicationUser *)user;
- (void)finishCurrentSession;

- (void)endSessionWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;
- (void)endSession;

- (void)checkOpenSessionWithCompletion:(void (^)(BOOL sessionOpen))completion failure:(void (^)(NSError *error))failure;

@end

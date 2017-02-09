//
//  AFApplication.h
//  AFPlatform
//
//  Created by Ricardo Ramos on 1/24/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AFDictionaryModel.h"
#import "AFUserSession.h"

extern NSString * const AFApplicationDidFinishLoadingDataNotification;
extern NSString * const AFApplicationDidFailLoadingDataNotification;

@class AFUser;

@interface AFApplication : AFDictionaryModel

@property (readonly, nonatomic) NSString *applicationKey;
@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *projectName;
@property (readonly, nonatomic) NSString *appState;
@property (readonly, nonatomic) BOOL pushNotificationEnabled;
@property (readonly, nonatomic) NSString *pushApplicationKey;
@property (readonly, nonatomic) NSString *pushApplicationSecret;
@property (readonly, nonatomic) BOOL pushOnlyForLoggedUser;
@property (readonly, nonatomic) BOOL internetRequired;
@property (readonly, nonatomic) BOOL startupCache;
@property (readonly, nonatomic) BOOL deviceTrackerEnabled;
@property (readonly, nonatomic) BOOL authenticationRequired;
@property (readonly, nonatomic) BOOL socialConnectEnabled;
@property (readonly, nonatomic) BOOL dispatchEnabled;
@property (assign, nonatomic) AFUserSessionType userSessionType;
@property (readonly, nonatomic) NSString *googleAnalyticsKey;
@property (readonly, nonatomic) NSInteger userSessionMaxAgeInSeconds;
@property (assign, nonatomic) NSInteger supportedInterfaceOrientations;

+ (instancetype)shared;
+ (BOOL)applicationLoaded;
+ (void)startApplicationWithApplicationKey:(NSString *)applicationKey;

@end

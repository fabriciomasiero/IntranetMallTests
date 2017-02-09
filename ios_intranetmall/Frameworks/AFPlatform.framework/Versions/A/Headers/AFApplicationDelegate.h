//
//  AFApplicationDelegate.h
//  RadioMegaFM
//
//  Created by Ricardo Ramos on 2/1/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFApplicationDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setApplicationKey:(NSString *)applicationKey launchOptions:(NSDictionary *)launchOptions;
- (void)setApplicationKey:(NSString *)applicationKey launchOptions:(NSDictionary *)launchOptions apiKey:(NSString *)apiKey apiBaseURL:(NSURL *)apiBaseURL;
- (void)startApplicationWithKey:(NSString *)applicationKey launchOptions:(NSDictionary *)launchOptions;
- (void)startApplication;

- (void)applicationDidFinishLoadingData;
- (void)applicationDidFailLoadingData:(NSError *)error;
- (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo;
- (BOOL)shouldRegisterForNotificationsOnStartup;
- (void)registerForNotifications;
- (void)didRegisterForNotifications;

@end

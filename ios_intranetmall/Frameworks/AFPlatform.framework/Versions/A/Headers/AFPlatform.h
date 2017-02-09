//
//  AFPlatform.h
//  AFPlatform
//
//  Created by Ricardo Ramos on 4/12/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <AFPlatform/AFAPIClient.h>
#import <AFPlatform/AFViewController.h>
#import <AFPlatform/AFApplication.h>
#import <AFPlatform/AFDictionaryModel.h>
#import <AFPlatform/AFProjectKeyValue.h>
#import <AFPlatform/AFApplicationDelegate.h>
#import <AFPlatform/AFAnalytics.h>
#import <AFPlatform/AFPlatformBundle.h>
#import <AFPlatform/AFApplicationUser.h>
#import <AFPlatform/AFHashString.h>
#import <AFPlatform/AFMedia.h>

#ifdef DEBUG
#    define AFLog(...) NSLog(__VA_ARGS__)
#else
#    define AFLog(...) /* */
#endif
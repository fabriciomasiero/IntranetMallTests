//
//  AFAnalytics.h
//  RadioMegaFM
//
//  Created by Ricardo Ramos on 2/1/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFAnalytics : NSObject

@property (readonly, nonatomic) BOOL analyticsEnabled;
@property (assign, nonatomic) BOOL autoTrackEnabled;

+ (instancetype)shared;

+ (void)startTrackerWithGoogleAnalyticsKey:(NSString *)googleAnalyticsKey;
+ (void)trackPageView:(NSString *)name;
+ (void)trackEventWithCategory:(NSString *)category action:(NSString *)action label:(NSString *)label;

@end

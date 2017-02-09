//
//  NSDate+Extras.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSDate+DateTools.h>

@interface NSDate (Extras)

+ (NSDate *)dateFromString:(NSString *)s;
+ (NSDate *)dateFromStringShortDayMode:(NSString *)s;
+ (NSDate *)dateHourFromString:(NSString *)s;

+ (NSDate *)getMaximumDateYearAgo;

+ (NSDate *)getMinimumHour;
+ (NSDate *)getHourPlusMinute:(NSDate *)date;
+ (NSDate *)getHourPlusHour:(NSDate *)date;
+ (NSDate *)getMaximumHour;
+ (NSDate *)getDatePlusDay:(NSDate *)date;

+ (NSDate *)dateComposeDate:(NSDate *)date withHour:(NSDate *)hour;

- (BOOL)dateSinceFewMinutesAgo;

@end

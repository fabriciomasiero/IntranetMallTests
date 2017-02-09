//
//  NSDate+Extras.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "NSDate+Extras.h"

@implementation NSDate (Extras)


+ (NSDate *)dateFromString:(NSString *)s {
    
    if (s.length) {
        NSDate *date = [[NSDate alloc] init];
    
        s = [s stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
        date = [dateFormatter dateFromString:s];
    
        return date;
    } else {
        return [NSDate dateWithTimeIntervalSince1970:0];
    }
}
+ (NSDate *)dateFromStringShortDayMode:(NSString *)s {
    if (s.length) {
        NSDate *date = [[NSDate alloc] init];
        
        s = [s stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        
        date = [dateFormatter dateFromString:s];
        
        return date;
    } else {
        return nil;
    }
}
+ (NSDate *)dateHourFromString:(NSString *)s {
    if (s.length) {
        NSDate *date = [[NSDate alloc] init];
        
        s = [s stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        
        date = [dateFormatter dateFromString:s];
        
        return date;
    } else {
        return [NSDate dateWithTimeIntervalSince1970:0];
    }
}

+ (NSDate *)getMaximumDateYearAgo {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *componentsDate = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
   
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:[componentsDate day]];
    [comps setMonth:[componentsDate month]];
    [comps setYear:[componentsDate year] + 1];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    return date;
}
+ (NSDate *)getMinimumHour {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *componentsDate = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:[componentsDate day]];
    [comps setMonth:[componentsDate month]];
    [comps setYear:[componentsDate year] + 1];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    return date;
}
+ (NSDate *)getHourPlusMinute:(NSDate *)date {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *componentsDate = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:[componentsDate day]];
    [comps setMonth:[componentsDate month]];
    [comps setYear:[componentsDate year]];
    [comps setHour:[componentsDate hour]];
    [comps setMinute:[componentsDate minute] + 1];
    [comps setSecond:0];
    NSDate *dateNew = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    return dateNew;
}
+ (NSDate *)getHourPlusHour:(NSDate *)date {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *componentsDate = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:[componentsDate day]];
    [comps setMonth:[componentsDate month]];
    [comps setYear:[componentsDate year]];
    [comps setHour:[componentsDate hour] + 1];
    [comps setMinute:[componentsDate minute]];
    [comps setSecond:0];
    NSDate *dateNew = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    return dateNew;
}
+ (NSDate *)getMaximumHour {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *componentsDate = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:[componentsDate day]];
    [comps setMonth:[componentsDate month]];
    [comps setYear:[componentsDate year] + 1];
    [comps setHour:23];
    [comps setMinute:59];
    [comps setSecond:59];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    return date;
}

+ (NSDate *)getDatePlusDay:(NSDate *)date {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *componentsDate = [gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:[componentsDate day] + 1];
    [comps setMonth:[componentsDate month]];
    [comps setYear:[componentsDate year]];
    [comps setHour:[componentsDate hour]];
    
    NSDate *dateNew = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    return dateNew;
}

+ (NSDate *)dateComposeDate:(NSDate *)date withHour:(NSDate *)hour {
    return [NSDate dateWithYear:[date year] month:[date month] day:[date day] hour:[hour hour] minute:[hour minute] second:[hour second]];
}
- (BOOL)dateSinceFewMinutesAgo {
    NSDate *dateHour = self;
    
    double minutesAgo = [dateHour minutesAgo];
    if (minutesAgo > 4) {
        return NO;
    }
    return YES;
}

@end

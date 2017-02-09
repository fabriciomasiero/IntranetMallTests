//
//  AFIMUserCalendar.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMUserCalendar.h"
#import "NSDate+Extras.h"
#import "AFDatabaseManager.h"

@implementation AFIMUserCalendar

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        if ([dictionary containsKey:@"ddata"]) {
            _date = [self getDateValue:dictionary[@"ddata"]];
        }
        if ([dictionary containsKey:@"dutil"]) {
            _usefulDay = @([[self getValue:dictionary[@"dutil"]] integerValue]);
        }
        if ([dictionary containsKey:@"feriado"]) {
            _holiday = @([[self getValue:dictionary[@"feriado"]] integerValue]);
        }
        [[AFDatabaseManager sharedManager] createUserCalendar:self];
    }
    return self;
}


- (NSString *)getValue:(NSDictionary *)dic {
    if ([dic containsKey:@"text"]) {
        return [NSString stringWithFormat:@"%@", dic[@"text"]];
    } else {
        return @"";
    }
}

- (NSDate *)getDateValue:(NSDictionary *)dic {
    NSString *value = [self getValue:dic];
    return [NSDate dateFromStringShortDayMode:value];
}

@end

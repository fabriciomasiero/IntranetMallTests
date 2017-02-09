//
//  AFIMServiceOrderAuthorizedUsers.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderAuthorizedUsers.h"
#import "AFDatabaseManager.h"

@implementation AFIMServiceOrderAuthorizedUsers

- (id)initWithDictionary:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder; {
    if (self) {
        if ([dictionary containsKey:@"empresa"]) {
            _enterprise = [self getValue:dictionary[@"empresa"]];
        }
        if ([dictionary containsKey:@"id"]) {
            _userIdAuthorized = [self getNumberValue:dictionary[@"id"]];
        }
        if ([dictionary containsKey:@"idos"]) {
            _serviceOrderId = [self getNumberValue:dictionary[@"idos"]];
        }
        if ([dictionary containsKey:@"nome"]) {
            _name = [self getValue:dictionary[@"nome"]];
        }
        if ([dictionary containsKey:@"rg"]) {
            _documentInsideCountry = [self getValue:dictionary[@"rg"]];
        }
        if (serviceOrder) {
            [[AFDatabaseManager sharedManager] insertAuthorizedUsersInto:serviceOrder withAuthorized:self];
        }
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
- (NSNumber *)getNumberValue:(NSDictionary *)dic {
    return @([[self getValue:dic] integerValue]);
}

- (NSDate *)getDateValue:(NSDictionary *)dic {
    NSString *value = [self getValue:dic];
    return [NSDate dateFromString:value];
}

@end

//
//  AFIMServiceOrderDestinationUser.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderDestinationUser.h"
#import "AFDatabaseManager.h"

@implementation AFIMServiceOrderDestinationUser


- (id)initWithDictionary:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder {
    if (self) {
        
        if ([dictionary containsKey:@"empresa"]) {
            _enterprise = [self getValue:dictionary[@"empresa"]];
        }
        if ([dictionary containsKey:@"nomeUser"]) {
            _name = [self getValue:dictionary[@"nomeUser"]];
        }
        if ([dictionary containsKey:@"emailUser"]) {
            _email = [self getValue:dictionary[@"emailUser"]];
        }
        if ([dictionary containsKey:@"luc"]) {
            _luc = [self getValue:dictionary[@"luc"]];
        }
        if ([dictionary containsKey:@"telefone"]) {
            _phone = [self getValue:dictionary[@"telefone"]];
        }
        if ([dictionary containsKey:@"idUser"]) {
            _userIdDestination = [self getNumberValue:dictionary[@"idUser"]];
        }
        if (serviceOrder) {
            [[AFDatabaseManager sharedManager] insertDestinationUserInto:serviceOrder withDestinationUser:self];
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

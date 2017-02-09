//
//  AFIMServiceOrderApproved.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 18/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderApproved.h"

@implementation AFIMServiceOrderApproved

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        if ([dictionary containsKey:@"idos"]) {
            _serviceOrderId = [self getNumberValue:dictionary[@"idos"]];
        }
        if ([dictionary containsKey:@"observacoes"]) {
            _observations = [self getValue:dictionary[@"observacoes"]];
        }
        if ([dictionary containsKey:@"iduser"]) {
            _userId = [self getNumberValue:dictionary[@"iduser"]];
        }
        if ([dictionary containsKey:@"datacad"]) {
            _registerDate = [self getDateValue:dictionary[@"datacad"]];
        }
        if ([dictionary containsKey:@"horacad"]) {
            NSDate *newHour = [self getDateHourValue:dictionary[@"horacad"]];
            _registerHour = [NSDate dateComposeDate:_registerDate withHour:newHour];
        }
        
        if ([dictionary containsKey:@"idcomentario"]) {
            _commentId = [self getNumberValue:dictionary[@"idcomentario"]];
        }
        if ([dictionary containsKey:@"aprovacao"]) {
            _approvalStatus = [self getNumberValue:dictionary[@"aprovacao"]];
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
- (NSDate *)getDateHourValue:(NSDictionary *)dic {
    NSString *value = [self getValue:dic];
    return [NSDate dateHourFromString:value];
}

@end

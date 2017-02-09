//
//  AFIMServiceOrderApprovers.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderApprovers.h"
#import <CoreData/CoreData.h>
#import <ObjectiveRecord/ObjectiveRecord.h>
#import "ServiceOrderApprover+CoreDataClass.h"
#import "AFDatabaseManager.h"

@implementation AFIMServiceOrderApprovers

- (id)initWithDictionary:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder {
    if (self) {
        if ([dictionary containsKey:@"acao"]) {
            _action = [self getNumberValue:dictionary[@"acao"]];
        }
        if ([dictionary containsKey:@"alcadas"]) {
            _lofted = [self getNumberValue:dictionary[@"alcadas"]];
        }
        if ([dictionary containsKey:@"email"]) {
            _email = [self getValue:dictionary[@"email"]];
        }
        if ([dictionary containsKey:@"iduser"]) {
            _userApproverId = [self getNumberValue:dictionary[@"iduser"]];
        }
        if ([dictionary containsKey:@"nome"]) {
            _name = [self getValue:dictionary[@"nome"]];
        }
        if ([dictionary containsKey:@"suplente"]) {
            _substitute = [self getNumberValue:dictionary[@"suplente"]];
        }
        if (serviceOrder) {
            [[AFDatabaseManager sharedManager] insertApproversInto:serviceOrder withApprover:self];
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

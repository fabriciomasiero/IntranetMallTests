//
//  AFIMUserHome.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMUserHome.h"

@implementation AFIMUserHome

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        if ([dictionary containsKey:@"aguardandoaprovacao"]) {
            _waitingApproval = [self getNumberValue:dictionary[@"aguardandoaprovacao"]];
        }
        if ([dictionary containsKey:@"autorizacao"]) {
            _authorization = [self getNumberValue:dictionary[@"autorizacao"]];
        }
        if ([dictionary containsKey:@"circularnaolida"]) {
            _notReadCircular = [self getNumberValue:dictionary[@"circularnaolida"]];
        }
        if ([dictionary containsKey:@"emexecucao"]) {
            _running = [self getNumberValue:dictionary[@"emexecucao"]];
        }
        if ([dictionary containsKey:@"iduser"]) {
            _userId = [self getNumberValue:dictionary[@"iduser"]];
        }
        if ([dictionary containsKey:@"naoautorizado"]) {
            _notAuthorized = [self getNumberValue:dictionary[@"naoautorizado"]];
        }
        if ([dictionary containsKey:@"qtdfuncionario"]) {
            _officialsCount = [self getNumberValue:dictionary[@"qtdfuncionario"]];
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

@end

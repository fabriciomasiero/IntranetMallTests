//
//  AFIMServiceOrderObservations.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderObservations.h"
#import "AFDatabaseManager.h"

@implementation AFIMServiceOrderObservations


- (id)initWithDictionary:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder; {
    if (self) {
        if ([dictionary containsKey:@"idos"]) {
            _serviceOrderId = [self getNumberValue:dictionary[@"idos"]];
        }
        if ([dictionary containsKey:@"observacoes"]) {
            _observation = [self getValue:dictionary[@"observacoes"]];
        }
        if ([dictionary containsKey:@"iduser"]) {
            _userId = [self getNumberValue:dictionary[@"iduser"]];
        }
        if ([dictionary containsKey:@"datacad"]) {
            _registerDate = [self getDateValue:dictionary[@"datacad"]];
        }
        if ([dictionary containsKey:@"horacad"]) {
            _registerHour = [self getDateHourValue:dictionary[@"horacad"]];
        }
        if ([dictionary containsKey:@"idcomentario"]) {
            _observationId = [self getNumberValue:dictionary[@"idcomentario"]];
        }
        
        if ([dictionary containsKey:@"usuario"]) {
            NSDictionary *userDict = dictionary[@"usuario"];
            if ([userDict containsKey:@"idUser"]) {
                _userObservationId = [self getNumberValue:userDict[@"idUser"]];
            }
            if ([userDict containsKey:@"nomeUser"]) {
                _userObservationName = [self getValue:userDict[@"nomeUser"]];
            }
            if ([userDict containsKey:@"empresa"]) {
                _userObservationEnterprise = [self getValue:userDict[@"empresa"]];
            }
            if ([userDict containsKey:@"emailUser"]) {
                _userObservationEmail = [self getValue:userDict[@"emailUser"]];
            }
            if ([userDict containsKey:@"telefone"]) {
                _userObservationPhone = [self getValue:userDict[@"telefone"]];
            }
            if ([userDict containsKey:@"data"]) {
                _userObservationDate = [self getDateHourValue:userDict[@"data"]];
            }
        }
        if (serviceOrder) {
            [[AFDatabaseManager sharedManager] insertObservationsInto:serviceOrder withObservation:self];
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

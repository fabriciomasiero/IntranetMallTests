//
//  AFIMServiceOrderRule.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderRule.h"
#import "AFDatabaseManager.h"

@implementation AFIMServiceOrderRule

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        
//        if ([dictionary containsKey:@"id_ordemservico_regra"]) {
//            _serviceOrderRuleId = [self getNumberValue:dictionary[@"id_ordemservico_regra"]];
//        }
//        if ([dictionary containsKey:@"dia_semana"]) {
//            _weekDay = [self getNumberValue:dictionary[@"dia_semana"]];
//        }
//        if ([dictionary containsKey:@"permissao_dia"]) {
//            _dayPermission = [self getNumberValue:dictionary[@"permissao_dia"]];
//        }
//        if ([dictionary containsKey:@"hora_limite"]) {
//            _hourLimit = [self getDateValue:dictionary[@"hora_limite"]];
//        }
//        if ([dictionary containsKey:@"soma_dia_hora_ate_limite"]) {
//            _dayHourToLimit = [self getValue:dictionary[@"soma_dia_hora_ate_limite"]];
//        }
//        if ([dictionary containsKey:@"horario_ate_limite"]) {
//            _hourToLimit = [self getNumberValue:dictionary[@"horario_ate_limite"]];
//        }
//        if ([dictionary containsKey:@"ativo"]) {
//            _hourAfterLimit = [self getNumberValue:dictionary[@"ativo"]];
//        }
//        if ([dictionary containsKey:@"ativo"]) {
//            _active = [self getNumberValue:dictionary[@"ativo"]];
//        }
//        if ([dictionary containsKey:@"ativo"]) {
//            _active = [self getNumberValue:dictionary[@"ativo"]];
//        }
    }
    return self;
}

#pragma mark - NSDictiobary Infos
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

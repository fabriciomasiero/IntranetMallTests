//
//  AFIMUserTypeService.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMUserTypeService.h"

@implementation AFIMUserTypeService

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            if ([dictionary containsKey:@"ativo"]) {
                _active = [self getNumberValue:dictionary[@"ativo"]];
            }
            if ([dictionary containsKey:@"descricao"]) {
                _serviceDescription = [self getValue:dictionary[@"descricao"]];
            }
            if ([dictionary containsKey:@"fora_funcionamento"]) {
                _outOfService = [self getNumberValue:dictionary[@"fora_funcionamento"]];
            }
            if ([dictionary containsKey:@"id_depto"]) {
                _departmentId = [self getNumberValue:dictionary[@"id_depto"]];
            }
            if ([dictionary containsKey:@"id_ordemservico_setor"]) {
                _orderServiceSectorId = [self getNumberValue:dictionary[@"id_ordemservico_setor"]];
            }
            if ([dictionary containsKey:@"idtipo"]) {
                _typeId = [self getNumberValue:dictionary[@"idtipo"]];
            }
            if ([dictionary containsKey:@"obrigatorio_anexo"]) {
                _attachmentRequired = [self getNumberValue:dictionary[@"obrigatorio_anexo"]];
            }
            if ([dictionary containsKey:@"obrigatorio_obs"]) {
                _observationRequired = [self getNumberValue:dictionary[@"obrigatorio_obs"]];
            }
            if ([dictionary containsKey:@"obs"]) {
                _observation = [self getValue:dictionary[@"obs"]];
            }
        } else {
            NSLog(@"aqui da pau");
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

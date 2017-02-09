//
//  AFIMUserSector.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMUserSector.h"
#import "AFDatabaseManager.h"

@implementation AFIMUserSector


- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        
        if ([dictionary containsKey:@"descricao"]) {
            _sectorDescription = [self getValue:dictionary[@"descricao"]];
        }
        if ([dictionary containsKey:@"idsetor"]) {
            _sectorId = [self getNumberValue:dictionary[@"idsetor"]];
        }
        
        UserSector *userSector = [[AFDatabaseManager sharedManager] createUserSector:self];
        if ([dictionary containsKey:@"tipoServico"]) {
            NSDictionary *dicTypes = dictionary[@"tipoServico"];
            if ([dicTypes containsKey:@"listaTipoServico"]) {
                NSArray *allTypes = dicTypes[@"listaTipoServico"];
                
                NSMutableArray *types = [[NSMutableArray alloc] init];
                if ([allTypes isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *t in allTypes) {
                        AFIMUserTypeService *userType = [[AFIMUserTypeService alloc] initWithDictionary:t];
                        [types addObject:userType];
                        [[AFDatabaseManager sharedManager] insertSectorTypeInto:userSector withServiceType:userType];
                    }
                } else {
                    NSDictionary *dic = (NSDictionary *)allTypes;
                    AFIMUserTypeService *userType = [[AFIMUserTypeService alloc] initWithDictionary:dic];
                    [types addObject:userType];
                    [[AFDatabaseManager sharedManager] insertSectorTypeInto:userSector withServiceType:userType];
                }
            }
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

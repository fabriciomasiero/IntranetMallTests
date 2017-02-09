//
//  AFIMCircularReaders.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 30/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMCircularReaders.h"

@implementation AFIMCircularReaders

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        if ([dictionary containsKey:@"data_acessou"]) {
            _accessDate = [self getDateValue:dictionary[@"data_acessou"]];
        }
        
        if ([dictionary containsKey:@"empresa"]) {
            _enterprise = [self getValue:dictionary[@"empresa"]];
        }

        
        if ([dictionary containsKey:@"idControle"]) {
            _controlId = [self getNumberValue:dictionary[@"idControle"]];
        }

        
        if ([dictionary containsKey:@"idcircular"]) {
            _circularId = [self getNumberValue:dictionary[@"idcircular"]];
        }

        
        if ([dictionary containsKey:@"iduser"]) {
            _userId = [self getNumberValue:dictionary[@"iduser"]];
        }

        
        if ([dictionary containsKey:@"nome"]) {
            _name = [self getValue:dictionary[@"nome"]];
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
- (NSURL *)getUrlValue:(NSDictionary *)dic {
    return [NSURL URLWithString:[self getValue:dic]];
}


@end

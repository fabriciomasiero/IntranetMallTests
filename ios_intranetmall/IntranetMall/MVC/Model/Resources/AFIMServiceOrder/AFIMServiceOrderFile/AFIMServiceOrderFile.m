//
//  AFIMServiceOrderFile.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 05/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderFile.h"
#import "AFDatabaseManager.h"

@implementation AFIMServiceOrderFile


- (id)initWithDictionary:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder {
    if (self) {
        if ([dictionary containsKey:@"url"]) {
            _fileUrl = [self getValue:dictionary[@"url"]];
        }
        if ([dictionary containsKey:@"idarquivo"]) {
            _archiveId = [self getNumberValue:dictionary[@"idarquivo"]];
        }
        if ([dictionary containsKey:@"idos"]) {
            _serviceOrderId = [self getNumberValue:dictionary[@"idos"]];
        }
        if ([dictionary containsKey:@"iduser"]) {
            _userId = [self getNumberValue:dictionary[@"iduser"]];
        }
        if ([dictionary containsKey:@"codgerador"]) {
            _code = [self getValue:dictionary[@"codgerador"]];
        }
        if ([dictionary containsKey:@"extensao"]) {
            _fileExtension = [self getValue:dictionary[@"extensao"]];
        }
        if (serviceOrder) {
            [[AFDatabaseManager sharedManager] insertFileInto:serviceOrder withFile:self];
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

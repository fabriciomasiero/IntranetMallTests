//
//  AFIMUserDevice.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMUserDevice.h"

@implementation AFIMUserDevice

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        _deviceId = @([[self getValue:dictionary[@"idDevice"]] integerValue]);
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

@end

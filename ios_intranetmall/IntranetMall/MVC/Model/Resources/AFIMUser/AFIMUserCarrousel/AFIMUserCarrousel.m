//
//  AFIMUserCarrousel.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 23/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMUserCarrousel.h"

@implementation AFIMUserCarrousel


- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        if ([dictionary containsKey:@"id"]) {
            _imageId = [self getNumberValue:dictionary[@"id"]];
        }
        if ([dictionary containsKey:@"image"]) {
            _image = [self getValue:dictionary[@"image"]];
        }
        if ([dictionary containsKey:@"link"]) {
            _link = [self getValue:dictionary[@"link"]];
        }
        if ([dictionary containsKey:@"ordem"]) {
            _order = [self getNumberValue:dictionary[@"ordem"]];
        }
        if ([dictionary containsKey:@"tipo"]) {
            _imageType = [self getNumberValue:dictionary[@"tipo"]];
        }
        if ([dictionary containsKey:@"url"]) {
            _pictureUrl = [NSURL URLWithString:[self getValue:dictionary[@"url"]]];
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

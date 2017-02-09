//
//  AFIMShoppings.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 22/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMShoppings.h"


@implementation AFIMShoppings

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        if ([dictionary containsKey:@"Cracha"]) {
            _badge = [self getValue:dictionary[@"Cracha"]];
        }
        if ([dictionary containsKey:@"Id"]) {
            _shoppingId = @([[self getValue:dictionary[@"Id"]] integerValue]);
        } else {
            if ([dictionary containsKey:@"shoppingId"]) {
                _shoppingId = @([dictionary[@"shoppingId"] integerValue]);
            }
        }
        if ([dictionary containsKey:@"Logo"]) {
            _pictureUrl = [NSURL URLWithString:[self getValue:dictionary[@"Logo"]]];
        }
        if ([dictionary containsKey:@"Nome"]) {
            _name = [self getValue:dictionary[@"Nome"]];
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


+ (void)getShoppingsWithCompletion:(void (^)(NSArray *shoppings))completion failure:(void (^)(NSError *error))failure {
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"ListaShoppings" withParameters:nil andCompletion:^(id response) {
        NSArray *result = response[@"Shopping"];
        
        NSMutableArray *mutable = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in result) {
            [mutable addObject:[[AFIMShoppings alloc] initWithDictionary:dic]];
        }
        
        NSArray *shopps = [NSArray arrayWithArray:[mutable mutableCopy]];
        completion(shopps);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end

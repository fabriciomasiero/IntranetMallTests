//
//  AFPostalCode.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFPostalCode.h"
#import <AFNetworking/AFNetworking.h>

@implementation AFPostalCode

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        _address = [NSString stringWithFormat:@"%@", dictionary[@"address"]];
        _postalCode = [NSString stringWithFormat:@"%@", dictionary[@"code"]];
        _state = [NSString stringWithFormat:@"%@", dictionary[@"state"]];
        _city = [NSString stringWithFormat:@"%@", dictionary[@"city"]];
        _neighborhood = [NSString stringWithFormat:@"%@", dictionary[@"district"]];

    }
    return self;
}
+ (void)searchPostalCodeWithPostal:(NSString *)postal andCompletion:(void (^)(AFPostalCode *postalCodeAddress))completion failure:(void (^)(NSError *error))failure {
    NSString *string = [NSString stringWithFormat:@"http://apps.widenet.com.br/busca-cep/api/cep/%@.json", postal];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        AFPostalCode *postalCode = [[AFPostalCode alloc] initWithDictionary:responseObject];
        completion(postalCode);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
        failure(error);
    }];
    
    [operation start];
}


@end

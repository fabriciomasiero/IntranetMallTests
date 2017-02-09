//
//  AFPostalCode.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFDictionaryModel.h>

@interface AFPostalCode : AFDictionaryModel

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *postalCode;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *neighborhood;

+ (void)searchPostalCodeWithPostal:(NSString *)postal andCompletion:(void (^)(AFPostalCode *postalCodeAddress))completion failure:(void (^)(NSError *error))failure;

@end

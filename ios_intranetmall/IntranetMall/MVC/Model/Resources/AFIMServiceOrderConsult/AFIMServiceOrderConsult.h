//
//  AFIMServiceOrderConsult.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>


@interface AFIMServiceOrderConsult : AFDictionaryModel

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSDate *hour;
@property (strong, nonatomic) NSArray *servicesStatus;
@property (strong, nonatomic) NSArray *services;
@property (strong, nonatomic) NSArray *results;

@property (strong, nonatomic) NSArray *servicesTypeTitles;

- (BOOL)canConsult;

@end

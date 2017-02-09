//
//  AFIMServiceOrderRule.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Extras.h"
#import <AFPlatform/AFPlatform.h>
#import "NSDate+Extras.h"
#import "NSString+Extras.h"

@interface AFIMServiceOrderRule : AFDictionaryModel



@property (strong, nonatomic) NSNumber *serviceOrderRuleId;
@property (strong, nonatomic) NSNumber *weekDay;
@property (strong, nonatomic) NSNumber *dayPermission;
@property (strong, nonatomic) NSDate *hourAfterLimit;
@property (strong, nonatomic) NSNumber *daysAfterLimit;
@property (strong, nonatomic) NSDate *hourToLimit;
@property (strong, nonatomic) NSString *dayHourToLimit;
@property (strong, nonatomic) NSDate *hourLimit;
@property (strong, nonatomic) NSString *weekDayName;
@property (strong, nonatomic) NSDate *hourDayAfter;


@end

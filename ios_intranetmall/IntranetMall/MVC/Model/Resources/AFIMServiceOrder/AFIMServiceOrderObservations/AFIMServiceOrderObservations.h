//
//  AFIMServiceOrderObservations.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFDictionaryModel.h>
#import "NSDictionary+Extras.h"
#import "NSString+Extras.h"
#import "NSDate+Extras.h"
#import "ServiceOrder+CoreDataClass.h"

@interface AFIMServiceOrderObservations : AFDictionaryModel


- (id)initWithDictionary:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder;

@property (strong, nonatomic) NSNumber *serviceOrderId;
@property (strong, nonatomic) NSString *observation;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSDate *registerDate;
@property (strong, nonatomic) NSDate *registerHour;
@property (strong, nonatomic) NSNumber *observationId;

@property (strong, nonatomic) NSNumber *userObservationId;
@property (strong, nonatomic) NSString *userObservationName;
@property (strong, nonatomic) NSString *userObservationEnterprise;
@property (strong, nonatomic) NSString *userObservationEmail;
@property (strong, nonatomic) NSString *userObservationPhone;
@property (strong, nonatomic) NSDate *userObservationDate;


@end

//
//  AFIMUserTypeService.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"

@interface AFIMUserTypeService : AFDictionaryModel

@property (strong, nonatomic) NSNumber *active;
@property (strong, nonatomic) NSString *serviceDescription;
@property (strong, nonatomic) NSNumber *outOfService;
@property (strong, nonatomic) NSNumber *departmentId;
@property (strong, nonatomic) NSNumber *orderServiceSectorId;
@property (strong, nonatomic) NSNumber *typeId;
@property (strong, nonatomic) NSNumber *attachmentRequired;
@property (strong, nonatomic) NSNumber *observationRequired;
@property (strong, nonatomic) NSString *observation;



@end

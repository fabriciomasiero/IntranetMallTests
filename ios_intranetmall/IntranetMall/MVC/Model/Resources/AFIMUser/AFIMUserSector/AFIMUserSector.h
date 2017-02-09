//
//  AFIMUserSector.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"
#import "AFIMUserTypeService.h"

@interface AFIMUserSector : AFDictionaryModel

@property (strong, nonatomic) NSString *sectorDescription;
@property (strong, nonatomic) NSNumber *sectorId;
@property (strong, nonatomic) NSArray *serviceTypes;

@end

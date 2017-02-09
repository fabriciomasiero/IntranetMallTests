//
//  AFIMServiceOrderApproved.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 18/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"
#import "NSString+Extras.h"
#import "NSDate+Extras.h"

@interface AFIMServiceOrderApproved : AFDictionaryModel

@property (strong, nonatomic) NSNumber *serviceOrderId;
@property (strong, nonatomic) NSString *observations;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSDate *registerDate;
@property (strong, nonatomic) NSDate *registerHour;
@property (strong, nonatomic) NSNumber *commentId;
@property (strong, nonatomic) NSNumber *approvalStatus;


@end

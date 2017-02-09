//
//  AFIMUserHome.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"

@interface AFIMUserHome : AFDictionaryModel

@property (strong, nonatomic) NSNumber *waitingApproval;
@property (strong, nonatomic) NSNumber *authorization;
@property (strong, nonatomic) NSNumber *notReadCircular;
@property (strong, nonatomic) NSNumber *running;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSNumber *notAuthorized;
@property (strong, nonatomic) NSNumber *officialsCount;


@end

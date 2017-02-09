//
//  AFIMCircularReaders.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 30/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+Extras.h"
#import "NSDictionary+Extras.h"
#import <AFPlatform/AFPlatform.h>

@interface AFIMCircularReaders : AFDictionaryModel


@property (strong, nonatomic) NSDate *accessDate;
@property (strong, nonatomic) NSString *enterprise;
@property (strong, nonatomic) NSNumber *controlId;
@property (strong, nonatomic) NSNumber *circularId;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *name;



@end

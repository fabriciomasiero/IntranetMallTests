//
//  AFIMUserCalendar.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"

@interface AFIMUserCalendar : AFDictionaryModel

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSNumber *usefulDay;
@property (strong, nonatomic) NSNumber *holiday;



@end

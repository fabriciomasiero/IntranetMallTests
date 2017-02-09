//
//  AFIMUserDevice.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"

@interface AFIMUserDevice : AFDictionaryModel

@property (strong, nonatomic) NSNumber *deviceId;

@end

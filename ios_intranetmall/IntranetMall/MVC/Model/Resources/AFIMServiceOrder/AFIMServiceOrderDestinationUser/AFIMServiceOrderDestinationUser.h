//
//  AFIMServiceOrderDestinationUser.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Extras.h"
#import "NSString+Extras.h"
#import "NSDate+Extras.h"
#import "AFSOAPRequest.h"
#import "AFSoapAPIClient.h"
#import "AFIMUser.h"
#import "ServiceOrder+CoreDataClass.h"

@interface AFIMServiceOrderDestinationUser : AFDictionaryModel

- (id)initWithDictionary:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder;


@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *enterprise;
@property (strong, nonatomic) NSNumber *userIdDestination;
@property (strong, nonatomic) NSString *luc;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;


@end

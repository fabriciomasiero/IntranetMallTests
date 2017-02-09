//
//  AFIMServiceOrderApprovers.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"
#import "NSString+Extras.h"
#import "NSDate+Extras.h"
#import "AFSOAPRequest.h"
#import "AFSoapAPIClient.h"
#import "AFIMUser.h"
//#import "AFIMServiceOrder.h"
#import "ServiceOrder+CoreDataClass.h"

@interface AFIMServiceOrderApprovers : AFDictionaryModel

- (id)initWithDictionary:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder;

@property (strong, nonatomic) NSNumber *action;
@property (strong, nonatomic) NSNumber *lofted;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSNumber *userApproverId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *substitute;



@end

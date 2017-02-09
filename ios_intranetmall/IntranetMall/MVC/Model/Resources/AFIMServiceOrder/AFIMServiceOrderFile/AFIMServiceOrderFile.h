//
//  AFIMServiceOrderFile.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 05/01/17.
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

@interface AFIMServiceOrderFile : AFDictionaryModel

- (id)initWithDictionary:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder;

@property (strong, nonatomic) NSString *fileUrl;
@property (strong, nonatomic) NSNumber *archiveId;
@property (strong, nonatomic) NSNumber *serviceOrderId;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *fileExtension;

@end

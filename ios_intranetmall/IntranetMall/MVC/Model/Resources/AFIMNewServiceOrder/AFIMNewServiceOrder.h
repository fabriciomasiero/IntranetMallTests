//
//  AFIMNewServiceOrder.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserSector+CoreDataClass.h"
#import "UserServiceType+CoreDataClass.h"
#import "AFIMNewServiceOrderAuthorizedUsers.h"
#import "AFFile.h"
#import "AFIMUser.h"


typedef NS_ENUM(NSInteger, AFIMNewServiceOrderType) {
    AFIMNewServiceOrderTypeInitialDate = 0,
    AFIMNewServiceOrderTypeFinalDate = 1,
    AFIMNewServiceOrderTypeInitialHour = 2,
    AFIMNewServiceOrderTypeFinalHour = 3,
    AFIMNewServiceOrderTypeType = 4,
    AFIMNewServiceOrderTypeDescription = 5,
    AFIMNewServiceOrderTypeRequester = 6,
    AFIMNewServiceOrderTypeUsers = 7,
    AFIMNewServiceOrderTypeFiles = 8,
    AFIMNewServiceOrderTypeUnknown = 9
};

@interface AFIMNewServiceOrder : NSObject

- (id)initWithInitialDate:(NSDate *)initialDate finalDate:(NSDate *)finalDate initialHour:(NSDate *)initialHour finalHour:(NSDate *)finalHour userSector:(UserSector *)userSector userServiceType:(UserServiceType *)serviceType;

@property (strong, nonatomic) NSDate *initialDate;
@property (strong, nonatomic) NSDate *finalDate;
@property (strong, nonatomic) NSDate *initialHour;
@property (strong, nonatomic) NSDate *finalHour;
@property (strong, nonatomic) UserSector *userSector;
@property (strong, nonatomic) UserServiceType *serviceType;
@property (strong, nonatomic) NSString *serviceOrderDescription;
@property (strong, nonatomic) NSString *requesterName;
@property (strong, nonatomic) NSArray<AFIMNewServiceOrderAuthorizedUsers *> *users;
@property (strong, nonatomic) NSArray<AFFile *> *files;
@property (strong, nonatomic) AFIMUser *loggedUser;
@property (strong, nonatomic) NSNumber *destinationId;
@property (strong, nonatomic) NSString *userDestinationTypeName;


- (BOOL)serviceOrderIsNull;
- (NSDictionary *)serviceIncompleted;
- (NSDictionary *)serviceDetailIncompleted;
- (NSString *)textForItem:(NSString *)s;



@end

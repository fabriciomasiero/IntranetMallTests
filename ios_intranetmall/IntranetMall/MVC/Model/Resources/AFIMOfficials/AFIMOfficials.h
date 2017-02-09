//
//  AFIMOfficials.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"
#import "NSString+Extras.h"
#import "NSDate+Extras.h"
#import "AFSOAPRequest.h"
#import "AFSoapAPIClient.h"
#import "AFIMUser.h"

@interface AFIMOfficials : AFDictionaryModel

@property (strong, nonatomic) NSNumber *officialId;
@property (nonatomic) BOOL synced;
@property (strong, nonatomic) NSString *neighborhood;
@property (strong, nonatomic) NSString *officialRole;
@property (strong, nonatomic) NSString *postalCode;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *photoName;
@property (strong, nonatomic) NSString *complement;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *documentIdentifier;
@property (strong, nonatomic) NSDate *adminDate;
@property (strong, nonatomic) NSDate *resignationDate;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSDate *registerDate;
@property (strong, nonatomic) NSString *badgeDescription;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *momFiliation;
@property (strong, nonatomic) NSString *dadFilitation;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSNumber *registerId;
@property (strong, nonatomic) NSString *imgBase64;
@property (strong, nonatomic) NSNumber *storeLuc;
@property (strong, nonatomic) NSString *storeName;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *naturalness;
@property (strong, nonatomic) NSString *shopkeeperName;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *plate;
@property (strong, nonatomic) NSString *documentInsideCountry;
@property (strong, nonatomic) NSString *sexuality;
@property (strong, nonatomic) NSNumber *registerStatus;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSDate *validateDate;


+ (void)getOfficialsWithUserId:(NSNumber *)userId shoppingId:(NSNumber *)shoppingId andCompletion:(void (^)(NSArray *officialList))completion failure:(void (^)(NSError *error))failure;

+ (void)saveOfficial:(NSDictionary *)dic user:(AFIMUser *)u andCompletion:(void (^)(NSInteger officialId))completion failure:(void (^)(NSError *error))failure;


- (NSString *)getRegisterStatusValue;


@end

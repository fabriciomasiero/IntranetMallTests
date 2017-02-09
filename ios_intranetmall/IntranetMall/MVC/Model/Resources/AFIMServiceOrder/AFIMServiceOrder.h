//
//  AFIMServiceOrder.h
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
#import "AFIMServiceOrderDestinationUser.h"
#import "AFIMNewServiceOrder.h"
#import "AFIMServiceOrderApproved.h"
#import "AFIMServiceOrderConsult.h"
#import "AFIMServiceOrderConsultService.h"


@interface AFIMServiceOrder : AFDictionaryModel

- (id)initWithDictionary:(NSDictionary *)dictionary saveCoreData:(BOOL)saveCoreData;

@property (strong, nonatomic) NSNumber *serviceOrderId;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSString *enterprise;
@property (strong, nonatomic) NSString *luc;
@property (strong, nonatomic) NSNumber *typeId;
@property (strong, nonatomic) NSDate *registerDate;
@property (strong, nonatomic) NSDate *registerHour;
@property (strong, nonatomic) NSDate *initialDate;
@property (strong, nonatomic) NSDate *initialHour;
@property (strong, nonatomic) NSDate *finalDate;
@property (strong, nonatomic) NSDate *finalHour;
@property (strong, nonatomic) NSDate *initialDateHour;
@property (strong, nonatomic) NSDate *finalDateHour;
@property (strong, nonatomic) NSNumber *statusId;
@property (strong, nonatomic) NSString *shopkeeperName;
@property (strong, nonatomic) NSString *requesterName;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *serviceOrderDescription;
@property (strong, nonatomic) NSNumber *destinationId;
//@property (strong, nonatomic) NSString *observations;
@property (strong, nonatomic) NSString *status;
@property (nonatomic) BOOL synced;
@property (strong, nonatomic) NSString *imgNameStatus;
@property (strong, nonatomic) NSString *serviceType;
@property (strong, nonatomic) NSArray *approvers;
@property (strong, nonatomic) NSArray *authorizedUsers;
@property (strong, nonatomic) NSArray *files;
@property (strong, nonatomic) NSArray *observations;
@property (strong, nonatomic) AFIMServiceOrderDestinationUser *userDestination;





+ (void)getServiceOrdersWithUserId:(NSNumber *)userId shoppingId:(NSNumber *)shoppingId userType:(NSNumber *)userType andCompletion:(void (^)(NSArray *serviceOrderList))completion failure:(void (^)(NSError *error))failure;

+ (void)saveServiceOrder:(AFIMNewServiceOrder *)serviceOrder andCompletion:(void (^)(AFIMServiceOrder *newServiceOrder))completion failure:(void (^)(NSError *error))failure;


+ (void)approveServiceOrder:(ServiceOrder *)serviceOrder user:(AFIMUser *)user observationText:(NSString *)observationText approvalStatus:(AFIMServiceOrderApprovalStatus)status andCompletion:(void (^)(AFIMServiceOrderApproved *serviceOrderApproved))completion failure:(void (^)(NSError *error))failure;

+ (void)consultServiceOrder:(AFIMServiceOrderConsult *)serviceOrderConsult withServices:(NSArray *)servicesStatus servicesTypes:(NSArray *)servicesTypes user:(AFIMUser *)user andCompletion:(void (^)(NSArray *serviceOrders))completion failure:(void (^)(NSError *error))failure;



+ (NSArray *)getStatusList;


@end

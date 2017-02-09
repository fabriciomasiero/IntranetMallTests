//
//  AFDatabaseManager.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 14/12/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFIMCircular.h"
#import "AFIMOfficials.h"
#import "AFIMCircularReaders.h"
#import "AFIMCircular.h"
#import "AFIMServiceOrder.h"
#import "AFIMServiceOrderApprovers.h"
#import "AFIMServiceOrderAuthorizedUsers.h"
#import "AFIMServiceOrderFile.h"
#import "AFIMUserCalendar.h"
#import "AFIMServiceOrderObservations.h"

#import <CoreData/CoreData.h>
#import <ObjectiveRecord/ObjectiveRecord.h>


#import "Circular+CoreDataClass.h"
#import "CircularReader+CoreDataClass.h"
#import "Official+CoreDataClass.h"
#import "ServiceOrder+CoreDataClass.h"
#import "ServiceOrderDestinationUser+CoreDataClass.h"
#import "ServiceOrderAuthorizedUser+CoreDataClass.h"
#import "ServiceOrderApprover+CoreDataClass.h"
#import "ServiceOrderFile+CoreDataClass.h"
#import "UserSector+CoreDataClass.h"
#import "UserServiceType+CoreDataClass.h"
#import "UserCalendar+CoreDataClass.h"
#import "ServiceOrderObservations+CoreDataClass.h"

@interface AFDatabaseManager : NSObject


+ (AFDatabaseManager *)sharedManager;

#pragma mark - Circular
- (Circular *)createCircular:(AFIMCircular *)circular;
- (void)insertReaders:(NSArray *)readers inCircular:(Circular *)circular;
- (NSArray *)searchOnCircular:(NSString *)text;

#pragma mark - Official
- (Official *)createOfficial:(AFIMOfficials *)official;
- (NSArray *)searchOnOfficial:(NSString *)text;
- (NSInteger)getLastOfficialId;

#pragma mark - Service Order
- (ServiceOrder *)createServiceOrder:(AFIMServiceOrder *)serviceOrder;
- (void)insertApproversInto:(ServiceOrder *)serviceOrder withApprover:(AFIMServiceOrderApprovers *)serviceOrderApprover;
- (void)insertAuthorizedUsersInto:(ServiceOrder *)serviceOrder withAuthorized:(AFIMServiceOrderAuthorizedUsers *)authorizedUsers;
- (void)insertDestinationUserInto:(ServiceOrder *)serviceOrder withDestinationUser:(AFIMServiceOrderDestinationUser *)destinationUser;
- (void)insertFileInto:(ServiceOrder *)serviceOrder withFile:(AFIMServiceOrderFile *)file;
- (NSArray *)searchOnServiceOrder:(NSString *)text;
- (ServiceOrder *)createNewServiceOrder:(AFIMNewServiceOrder *)newServiceOrder withNewDictionaryServiceOrder:(AFIMServiceOrder *)newSO;

#pragma mark - User Sector
- (UserSector *)createUserSector:(AFIMUserSector *)sector;
- (void)insertSectorTypeInto:(UserSector *)userSector withServiceType:(AFIMUserTypeService *)typeService;

#pragma mark - Authorized User
- (ServiceOrderAuthorizedUser *)createAuthorizedUser:(NSString *)name documentInsideCountry:(NSString *)documentInsideCountry enterprise:(NSString *)enterprise;
//- (NSInteger)getLastAuthorizedId;
- (NSArray *)getCorrectAuthorizedUsers;

#pragma mark - User Calendar
- (UserCalendar *)createUserCalendar:(AFIMUserCalendar *)userCalendar;

#pragma mark - Observations
- (void)insertObservationsInto:(ServiceOrder *)serviceOrder withObservation:(AFIMServiceOrderObservations *)orderObservations;

#pragma mark - Getters
- (NSArray *)getRecentServiceOrders;



@end

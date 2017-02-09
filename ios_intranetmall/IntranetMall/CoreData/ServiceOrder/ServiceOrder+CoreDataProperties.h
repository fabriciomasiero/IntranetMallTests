//
//  ServiceOrder+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 30/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ServiceOrder (CoreDataProperties)

+ (NSFetchRequest<ServiceOrder *> *)fetchRequest;

@property (nonatomic) int32_t destinationId;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *enterprise;
@property (nullable, nonatomic, copy) NSDate *finalDate;
@property (nullable, nonatomic, copy) NSDate *finalDateHour;
@property (nullable, nonatomic, copy) NSDate *finalHour;
@property (nullable, nonatomic, copy) NSString *imgStatus;
@property (nullable, nonatomic, copy) NSDate *initialDate;
@property (nullable, nonatomic, copy) NSDate *initialDateHour;
@property (nullable, nonatomic, copy) NSDate *initialHour;
@property (nullable, nonatomic, copy) NSString *luc;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSDate *registerDate;
@property (nullable, nonatomic, copy) NSDate *registerHour;
@property (nullable, nonatomic, copy) NSString *requesterName;
@property (nullable, nonatomic, copy) NSString *serviceOrderDescription;
@property (nonatomic) int32_t serviceOrderId;
@property (nullable, nonatomic, copy) NSString *serviceType;
@property (nullable, nonatomic, copy) NSString *shopkeeperName;
@property (nullable, nonatomic, copy) NSString *status;
@property (nonatomic) int32_t statusId;
@property (nonatomic) BOOL synced;
@property (nonatomic) int32_t typeId;
@property (nonatomic) int32_t userId;
@property (nullable, nonatomic, retain) NSSet<ServiceOrderApprover *> *approvers;
@property (nullable, nonatomic, retain) NSSet<ServiceOrderAuthorizedUser *> *authorizedUsers;
@property (nullable, nonatomic, retain) ServiceOrderDestinationUser *destinationUser;
@property (nullable, nonatomic, retain) NSSet<ServiceOrderFile *> *files;
@property (nullable, nonatomic, retain) NSSet<ServiceOrderObservations *> *observations;

@end

@interface ServiceOrder (CoreDataGeneratedAccessors)

- (void)addApproversObject:(ServiceOrderApprover *)value;
- (void)removeApproversObject:(ServiceOrderApprover *)value;
- (void)addApprovers:(NSSet<ServiceOrderApprover *> *)values;
- (void)removeApprovers:(NSSet<ServiceOrderApprover *> *)values;

- (void)addAuthorizedUsersObject:(ServiceOrderAuthorizedUser *)value;
- (void)removeAuthorizedUsersObject:(ServiceOrderAuthorizedUser *)value;
- (void)addAuthorizedUsers:(NSSet<ServiceOrderAuthorizedUser *> *)values;
- (void)removeAuthorizedUsers:(NSSet<ServiceOrderAuthorizedUser *> *)values;

- (void)addFilesObject:(ServiceOrderFile *)value;
- (void)removeFilesObject:(ServiceOrderFile *)value;
- (void)addFiles:(NSSet<ServiceOrderFile *> *)values;
- (void)removeFiles:(NSSet<ServiceOrderFile *> *)values;

- (void)addObservationsObject:(ServiceOrderObservations *)value;
- (void)removeObservationsObject:(ServiceOrderObservations *)value;
- (void)addObservations:(NSSet<ServiceOrderObservations *> *)values;
- (void)removeObservations:(NSSet<ServiceOrderObservations *> *)values;

@end

NS_ASSUME_NONNULL_END

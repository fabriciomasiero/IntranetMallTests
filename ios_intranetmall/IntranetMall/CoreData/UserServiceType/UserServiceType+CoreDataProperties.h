//
//  UserServiceType+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "UserServiceType+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserServiceType (CoreDataProperties)

+ (NSFetchRequest<UserServiceType *> *)fetchRequest;

@property (nonatomic) BOOL active;
@property (nonatomic) BOOL attachmentRequired;
@property (nonatomic) int32_t departmentId;
@property (nullable, nonatomic, copy) NSString *observation;
@property (nonatomic) BOOL observationRequired;
@property (nonatomic) int32_t orderServiceSectorId;
@property (nonatomic) int32_t outOfService;
@property (nonatomic) BOOL selected;
@property (nullable, nonatomic, copy) NSString *serviceDescription;
@property (nonatomic) int32_t typeId;
@property (nullable, nonatomic, retain) UserSector *sector;

@end

NS_ASSUME_NONNULL_END

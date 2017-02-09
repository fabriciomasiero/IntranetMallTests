//
//  UserSector+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "UserSector+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserSector (CoreDataProperties)

+ (NSFetchRequest<UserSector *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *sectorDescription;
@property (nonatomic) int32_t sectorId;
@property (nullable, nonatomic, retain) NSSet<UserServiceType *> *serviceTypes;

@end

@interface UserSector (CoreDataGeneratedAccessors)

- (void)addServiceTypesObject:(UserServiceType *)value;
- (void)removeServiceTypesObject:(UserServiceType *)value;
- (void)addServiceTypes:(NSSet<UserServiceType *> *)values;
- (void)removeServiceTypes:(NSSet<UserServiceType *> *)values;

@end

NS_ASSUME_NONNULL_END

//
//  Official+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "Official+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Official (CoreDataProperties)

+ (NSFetchRequest<Official *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSDate *adminDate;
@property (nullable, nonatomic, copy) NSString *badgeDescription;
@property (nullable, nonatomic, copy) NSDate *birthDate;
@property (nullable, nonatomic, copy) NSString *brand;
@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *color;
@property (nullable, nonatomic, copy) NSString *complement;
@property (nullable, nonatomic, copy) NSString *dadFilitation;
@property (nullable, nonatomic, copy) NSString *documentIdentifier;
@property (nullable, nonatomic, copy) NSString *documentInsideCountry;
@property (nullable, nonatomic, copy) NSString *imgBase64;
@property (nullable, nonatomic, copy) NSString *model;
@property (nullable, nonatomic, copy) NSString *momFiliation;
@property (nullable, nonatomic, copy) NSString *naturalness;
@property (nullable, nonatomic, copy) NSString *neighborhood;
@property (nullable, nonatomic, copy) NSString *number;
@property (nonatomic) int32_t officialId;
@property (nullable, nonatomic, copy) NSString *officialRole;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *photoName;
@property (nullable, nonatomic, copy) NSString *plate;
@property (nullable, nonatomic, copy) NSString *postalCode;
@property (nullable, nonatomic, copy) NSDate *registerDate;
@property (nonatomic) int32_t registerId;
@property (nonatomic) int32_t registerStatus;
@property (nullable, nonatomic, copy) NSString *registerStatusValue;
@property (nullable, nonatomic, copy) NSDate *resignationDate;
@property (nullable, nonatomic, copy) NSString *sexuality;
@property (nullable, nonatomic, copy) NSString *shopkeeperName;
@property (nullable, nonatomic, copy) NSString *state;
@property (nonatomic) int32_t storeLuc;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nonatomic) BOOL synced;
@property (nonatomic) int32_t userId;
@property (nullable, nonatomic, copy) NSDate *validateDate;

@end

NS_ASSUME_NONNULL_END

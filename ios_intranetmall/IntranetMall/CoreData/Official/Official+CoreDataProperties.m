//
//  Official+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "Official+CoreDataProperties.h"

@implementation Official (CoreDataProperties)

+ (NSFetchRequest<Official *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Official"];
}

@dynamic address;
@dynamic adminDate;
@dynamic badgeDescription;
@dynamic birthDate;
@dynamic brand;
@dynamic city;
@dynamic color;
@dynamic complement;
@dynamic dadFilitation;
@dynamic documentIdentifier;
@dynamic documentInsideCountry;
@dynamic imgBase64;
@dynamic model;
@dynamic momFiliation;
@dynamic naturalness;
@dynamic neighborhood;
@dynamic number;
@dynamic officialId;
@dynamic officialRole;
@dynamic phone;
@dynamic photoName;
@dynamic plate;
@dynamic postalCode;
@dynamic registerDate;
@dynamic registerId;
@dynamic registerStatus;
@dynamic registerStatusValue;
@dynamic resignationDate;
@dynamic sexuality;
@dynamic shopkeeperName;
@dynamic state;
@dynamic storeLuc;
@dynamic storeName;
@dynamic synced;
@dynamic userId;
@dynamic validateDate;

@end

//
//  UserSector+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "UserSector+CoreDataProperties.h"

@implementation UserSector (CoreDataProperties)

+ (NSFetchRequest<UserSector *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserSector"];
}

@dynamic sectorDescription;
@dynamic sectorId;
@dynamic serviceTypes;

@end

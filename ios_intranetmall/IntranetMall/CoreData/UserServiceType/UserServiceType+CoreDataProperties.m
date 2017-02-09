//
//  UserServiceType+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "UserServiceType+CoreDataProperties.h"

@implementation UserServiceType (CoreDataProperties)

+ (NSFetchRequest<UserServiceType *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserServiceType"];
}

@dynamic active;
@dynamic attachmentRequired;
@dynamic departmentId;
@dynamic observation;
@dynamic observationRequired;
@dynamic orderServiceSectorId;
@dynamic outOfService;
@dynamic selected;
@dynamic serviceDescription;
@dynamic typeId;
@dynamic sector;

@end

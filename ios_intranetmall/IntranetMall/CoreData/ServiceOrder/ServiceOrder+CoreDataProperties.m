//
//  ServiceOrder+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 30/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrder+CoreDataProperties.h"

@implementation ServiceOrder (CoreDataProperties)

+ (NSFetchRequest<ServiceOrder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ServiceOrder"];
}

@dynamic destinationId;
@dynamic email;
@dynamic enterprise;
@dynamic finalDate;
@dynamic finalDateHour;
@dynamic finalHour;
@dynamic imgStatus;
@dynamic initialDate;
@dynamic initialDateHour;
@dynamic initialHour;
@dynamic luc;
@dynamic phone;
@dynamic registerDate;
@dynamic registerHour;
@dynamic requesterName;
@dynamic serviceOrderDescription;
@dynamic serviceOrderId;
@dynamic serviceType;
@dynamic shopkeeperName;
@dynamic status;
@dynamic statusId;
@dynamic synced;
@dynamic typeId;
@dynamic userId;
@dynamic approvers;
@dynamic authorizedUsers;
@dynamic destinationUser;
@dynamic files;
@dynamic observations;

@end

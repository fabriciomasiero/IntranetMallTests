//
//  ServiceOrderAuthorizedUser+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderAuthorizedUser+CoreDataProperties.h"

@implementation ServiceOrderAuthorizedUser (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderAuthorizedUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ServiceOrderAuthorizedUser"];
}

@dynamic documentInsideCountry;
@dynamic enterprise;
@dynamic name;
@dynamic serviceOrderId;
@dynamic userIdAuthorized;
@dynamic serviceOrder;

@end

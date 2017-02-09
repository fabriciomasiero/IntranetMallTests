//
//  ServiceOrderDestinationUser+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderDestinationUser+CoreDataProperties.h"

@implementation ServiceOrderDestinationUser (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderDestinationUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ServiceOrderDestinationUser"];
}

@dynamic email;
@dynamic enterprise;
@dynamic luc;
@dynamic name;
@dynamic phone;
@dynamic userIdDestination;
@dynamic serviceOrder;

@end

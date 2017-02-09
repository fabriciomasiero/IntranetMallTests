//
//  ServiceOrderApprover+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderApprover+CoreDataProperties.h"

@implementation ServiceOrderApprover (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderApprover *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ServiceOrderApprover"];
}

@dynamic action;
@dynamic email;
@dynamic lofted;
@dynamic name;
@dynamic substitute;
@dynamic userApproverId;
@dynamic serviceOrderApproved;

@end

//
//  ServiceOrderFile+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderFile+CoreDataProperties.h"

@implementation ServiceOrderFile (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderFile *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ServiceOrderFile"];
}

@dynamic archiveId;
@dynamic code;
@dynamic fileExtension;
@dynamic fileUrl;
@dynamic serviceOrderId;
@dynamic userId;
@dynamic serviceOrder;

@end

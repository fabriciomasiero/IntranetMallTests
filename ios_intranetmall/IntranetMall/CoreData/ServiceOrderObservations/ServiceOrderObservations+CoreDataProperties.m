//
//  ServiceOrderObservations+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 30/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderObservations+CoreDataProperties.h"

@implementation ServiceOrderObservations (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderObservations *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ServiceOrderObservations"];
}

@dynamic serviceOrderId;
@dynamic observation;
@dynamic userId;
@dynamic registerDate;
@dynamic registerHour;
@dynamic observationId;
@dynamic userObservationId;
@dynamic userObservationName;
@dynamic userObservationEnterprise;
@dynamic userObservationPhone;
@dynamic userObservationDate;
@dynamic userObservationEmail;
@dynamic serviceOrder;

@end

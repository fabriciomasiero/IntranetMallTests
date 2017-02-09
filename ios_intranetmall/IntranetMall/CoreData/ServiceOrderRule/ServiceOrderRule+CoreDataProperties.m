//
//  ServiceOrderRule+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderRule+CoreDataProperties.h"

@implementation ServiceOrderRule (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderRule *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ServiceOrderRule"];
}

@dynamic serviceOrderRuleId;
@dynamic weekDay;
@dynamic dayPermission;
@dynamic hourAfterLimit;
@dynamic daysAfterLimit;
@dynamic hourToLimit;
@dynamic dayHourToLimit;
@dynamic hourLimit;
@dynamic weekDayName;
@dynamic hourDayAfter;

@end

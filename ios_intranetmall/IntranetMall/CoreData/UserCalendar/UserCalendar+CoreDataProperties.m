//
//  UserCalendar+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 17/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "UserCalendar+CoreDataProperties.h"

@implementation UserCalendar (CoreDataProperties)

+ (NSFetchRequest<UserCalendar *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserCalendar"];
}

@dynamic date;
@dynamic usefulDay;
@dynamic holiday;

@end

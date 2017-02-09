//
//  CircularReader+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "CircularReader+CoreDataProperties.h"

@implementation CircularReader (CoreDataProperties)

+ (NSFetchRequest<CircularReader *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CircularReader"];
}

@dynamic accessDate;
@dynamic circularId;
@dynamic controlId;
@dynamic enterprise;
@dynamic name;
@dynamic userId;
@dynamic circular;

@end

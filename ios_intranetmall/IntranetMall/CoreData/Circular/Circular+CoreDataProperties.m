//
//  Circular+CoreDataProperties.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "Circular+CoreDataProperties.h"

@implementation Circular (CoreDataProperties)

+ (NSFetchRequest<Circular *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Circular"];
}

@dynamic accessCount;
@dynamic archiveName;
@dynamic circularId;
@dynamic read;
@dynamic registerDate;
@dynamic title;
@dynamic userId;
@dynamic reader;

@end

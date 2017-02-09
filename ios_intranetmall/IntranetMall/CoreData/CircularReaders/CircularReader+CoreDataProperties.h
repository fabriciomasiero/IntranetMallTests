//
//  CircularReader+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "CircularReader+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CircularReader (CoreDataProperties)

+ (NSFetchRequest<CircularReader *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *accessDate;
@property (nonatomic) int32_t circularId;
@property (nonatomic) int32_t controlId;
@property (nullable, nonatomic, copy) NSString *enterprise;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t userId;
@property (nullable, nonatomic, retain) Circular *circular;

@end

NS_ASSUME_NONNULL_END

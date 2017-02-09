//
//  Circular+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "Circular+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Circular (CoreDataProperties)

+ (NSFetchRequest<Circular *> *)fetchRequest;

@property (nonatomic) int32_t accessCount;
@property (nullable, nonatomic, copy) NSString *archiveName;
@property (nonatomic) int32_t circularId;
@property (nonatomic) BOOL read;
@property (nullable, nonatomic, copy) NSDate *registerDate;
@property (nullable, nonatomic, copy) NSString *title;
@property (nonatomic) int32_t userId;
@property (nullable, nonatomic, retain) NSSet<CircularReader *> *reader;

@end

@interface Circular (CoreDataGeneratedAccessors)

- (void)addReaderObject:(CircularReader *)value;
- (void)removeReaderObject:(CircularReader *)value;
- (void)addReader:(NSSet<CircularReader *> *)values;
- (void)removeReader:(NSSet<CircularReader *> *)values;

@end

NS_ASSUME_NONNULL_END

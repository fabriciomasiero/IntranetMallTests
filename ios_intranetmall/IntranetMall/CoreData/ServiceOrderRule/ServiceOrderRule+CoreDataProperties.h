//
//  ServiceOrderRule+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderRule+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ServiceOrderRule (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderRule *> *)fetchRequest;

@property (nonatomic) int32_t serviceOrderRuleId;
@property (nonatomic) int32_t weekDay;
@property (nonatomic) int32_t dayPermission;
@property (nullable, nonatomic, copy) NSDate *hourAfterLimit;
@property (nonatomic) int32_t daysAfterLimit;
@property (nullable, nonatomic, copy) NSDate *hourToLimit;
@property (nullable, nonatomic, copy) NSString *dayHourToLimit;
@property (nullable, nonatomic, copy) NSDate *hourLimit;
@property (nullable, nonatomic, copy) NSString *weekDayName;
@property (nullable, nonatomic, copy) NSDate *hourDayAfter;

@end

NS_ASSUME_NONNULL_END

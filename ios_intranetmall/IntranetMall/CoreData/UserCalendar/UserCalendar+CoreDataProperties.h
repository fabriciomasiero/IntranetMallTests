//
//  UserCalendar+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 17/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "UserCalendar+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserCalendar (CoreDataProperties)

+ (NSFetchRequest<UserCalendar *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) BOOL usefulDay;
@property (nonatomic) BOOL holiday;

@end

NS_ASSUME_NONNULL_END

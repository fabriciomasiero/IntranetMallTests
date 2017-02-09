//
//  ServiceOrderObservations+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 30/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderObservations+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ServiceOrderObservations (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderObservations *> *)fetchRequest;

@property (nonatomic) int32_t serviceOrderId;
@property (nullable, nonatomic, copy) NSString *observation;
@property (nonatomic) int32_t userId;
@property (nullable, nonatomic, copy) NSDate *registerDate;
@property (nullable, nonatomic, copy) NSDate *registerHour;
@property (nonatomic) int32_t observationId;
@property (nonatomic) int32_t userObservationId;
@property (nullable, nonatomic, copy) NSString *userObservationName;
@property (nullable, nonatomic, copy) NSString *userObservationEnterprise;
@property (nullable, nonatomic, copy) NSString *userObservationPhone;
@property (nullable, nonatomic, copy) NSDate *userObservationDate;
@property (nullable, nonatomic, copy) NSString *userObservationEmail;
@property (nullable, nonatomic, retain) ServiceOrder *serviceOrder;

@end

NS_ASSUME_NONNULL_END

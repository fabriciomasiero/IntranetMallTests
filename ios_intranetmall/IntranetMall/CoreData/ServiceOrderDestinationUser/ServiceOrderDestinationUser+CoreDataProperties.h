//
//  ServiceOrderDestinationUser+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderDestinationUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ServiceOrderDestinationUser (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderDestinationUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *enterprise;
@property (nullable, nonatomic, copy) NSString *luc;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nonatomic) int32_t userIdDestination;
@property (nullable, nonatomic, retain) ServiceOrder *serviceOrder;

@end

NS_ASSUME_NONNULL_END

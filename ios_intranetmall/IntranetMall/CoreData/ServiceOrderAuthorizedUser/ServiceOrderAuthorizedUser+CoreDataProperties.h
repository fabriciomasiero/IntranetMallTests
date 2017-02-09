//
//  ServiceOrderAuthorizedUser+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderAuthorizedUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ServiceOrderAuthorizedUser (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderAuthorizedUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *documentInsideCountry;
@property (nullable, nonatomic, copy) NSString *enterprise;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t serviceOrderId;
@property (nonatomic) int32_t userIdAuthorized;
@property (nullable, nonatomic, retain) ServiceOrder *serviceOrder;

@end

NS_ASSUME_NONNULL_END

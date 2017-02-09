//
//  ServiceOrderApprover+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderApprover+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ServiceOrderApprover (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderApprover *> *)fetchRequest;

@property (nonatomic) int32_t action;
@property (nullable, nonatomic, copy) NSString *email;
@property (nonatomic) int32_t lofted;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t substitute;
@property (nonatomic) int32_t userApproverId;
@property (nullable, nonatomic, retain) ServiceOrder *serviceOrderApproved;

@end

NS_ASSUME_NONNULL_END

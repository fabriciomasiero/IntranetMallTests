//
//  ServiceOrderFile+CoreDataProperties.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 27/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "ServiceOrderFile+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ServiceOrderFile (CoreDataProperties)

+ (NSFetchRequest<ServiceOrderFile *> *)fetchRequest;

@property (nonatomic) int32_t archiveId;
@property (nullable, nonatomic, copy) NSString *code;
@property (nullable, nonatomic, copy) NSString *fileExtension;
@property (nullable, nonatomic, copy) NSString *fileUrl;
@property (nonatomic) int32_t serviceOrderId;
@property (nonatomic) int32_t userId;
@property (nullable, nonatomic, retain) ServiceOrder *serviceOrder;

@end

NS_ASSUME_NONNULL_END

//
//  ServiceOrder+CoreDataClass.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 30/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ServiceOrderApprover, ServiceOrderAuthorizedUser, ServiceOrderDestinationUser, ServiceOrderFile, ServiceOrderObservations;

NS_ASSUME_NONNULL_BEGIN

@interface ServiceOrder : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ServiceOrder+CoreDataProperties.h"

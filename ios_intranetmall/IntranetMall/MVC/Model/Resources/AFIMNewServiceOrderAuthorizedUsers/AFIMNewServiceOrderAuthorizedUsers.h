//
//  AFIMNewServiceOrderAuthorizedUsers.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 12/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceOrderAuthorizedUser+CoreDataClass.h"

@interface AFIMNewServiceOrderAuthorizedUsers : NSObject

- (id)initWithUser:(ServiceOrderAuthorizedUser *)user andSelected:(BOOL)selected;

@property (strong, nonatomic) ServiceOrderAuthorizedUser *user;
@property (nonatomic) BOOL selected;

@end

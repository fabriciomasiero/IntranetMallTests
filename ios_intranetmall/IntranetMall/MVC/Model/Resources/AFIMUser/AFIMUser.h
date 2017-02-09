//
//  AFIMUser.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 23/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Extras.h"
#import <AFPlatform/AFPlatform.h>
#import "AFIMUserCarrousel.h"
#import "AFIMUserDevice.h"
#import "AFIMUserHome.h"
#import "AFIMUserSector.h"

@interface AFIMUser : AFDictionaryModel

@property (strong, nonatomic) NSString *access;
@property (strong, nonatomic) NSString *contract;
@property (strong, nonatomic) NSDate *accessDate;
@property (strong, nonatomic) NSString *department;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *otherEmail;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSDate *accessHour;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSNumber *badgeTypeId;
@property (strong, nonatomic) NSString *shopData64;
@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSString *luc;
@property (strong, nonatomic) NSString *shoppingName;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *floor;
@property (strong, nonatomic) NSNumber *firstAccess;
@property (strong, nonatomic) NSString *social;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSNumber *userType;
@property (strong, nonatomic) NSNumber *shoppingId;


@property (strong, nonatomic) NSArray *carrousels;

@property (strong, nonatomic) NSArray *calendars;

@property (strong, nonatomic) AFIMUserDevice *device;

@property (strong, nonatomic) AFIMUserHome *home;

@property (strong, nonatomic) NSArray *sectors;



- (BOOL)isAdmin;





@end

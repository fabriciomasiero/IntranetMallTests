//
//  AFUser.h
//  Alsco
//
//  Created by Ricardo Ramos on 1/27/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <AFPlatform/AFDictionaryModel.h>
#import <AFPlatform/AFAPIClient.h>

typedef NS_ENUM(NSInteger, AFUserType) {
    AFUserTypeCMSUser,
    AFUserTypeApplicationUser,
};

@class AFSocialProfile;

@interface AFUser : AFDictionaryModel

@property (readonly, nonatomic) NSInteger userID;
@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *login;
@property (assign, nonatomic) AFUserType userType;
@property (strong, nonatomic) AFSocialProfile *socialProfile;

+ (instancetype)loggedUser;

+ (void)applicationLoginWithLogin:(NSString *)login password:(NSString *)password success:(void (^)(AFUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)applicationLoginWithStoredCredentialsWithSuccess:(void (^)(AFUser *user))success failure:(void (^)(NSError *error))failure;

@end

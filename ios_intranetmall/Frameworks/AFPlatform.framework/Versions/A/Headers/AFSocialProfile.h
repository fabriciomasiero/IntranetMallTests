//
//  AFSocialProfile.h
//  MPbrows
//
//  Created by Ricardo Ramos on 2/25/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <AFPlatform/AFUser.h>

@class AFUser;

@interface AFSocialProfile : AFDictionaryModel

@property (readonly, nonatomic) NSInteger socialProfileID;
@property (readonly, nonatomic) NSString *userID;
@property (readonly, nonatomic) NSString *userName;
@property (readonly, nonatomic) NSString *displayName;
@property (readonly, nonatomic) NSURL *pictureURL;


+ (void)saveSocialProfileWithUserID:(NSString *)userID userName:(NSString *)userName displayName:(NSString *)displayName success:(void (^)(AFSocialProfile *socialProfile, AFUser *user))success failure:(void (^)(NSError *error))failure;

@end

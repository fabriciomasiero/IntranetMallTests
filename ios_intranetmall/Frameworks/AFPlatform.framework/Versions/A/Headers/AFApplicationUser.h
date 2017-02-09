//
//  AFApplicationUser.h
//  AFPlatform
//
//  Created by Ricardo Ramos on 8/8/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <AFPlatform/AFPlatform.h>

typedef NS_ENUM(NSInteger, AFApplicationUserSourceType) {
    AFApplicationUserSourceTypeLocal = 1,
    AFApplicationUserSourceTypeFacebook = 2,
    AFApplicationUserSourceTypeGooglePlus = 3,
    AFApplicationUserSourceTypeOther = 99
};

@interface AFApplicationUser : AFDictionaryModel

@property (assign, nonatomic) NSInteger userID;
@property (assign, nonatomic) AFApplicationUserSourceType sourceType;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *login;
@property (strong, nonatomic) NSString *socialUserID;
@property (strong, nonatomic) NSDate *birthDate;
@property (strong, nonatomic) NSURL *pictureURL;
@property (strong, nonatomic) NSString *extras;
@property (assign, nonatomic) BOOL administrator;

+ (void)authenticateWithLogin:(NSString *)login password:(NSString *)password success:(void (^)(AFApplicationUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)authenticateWithStoredCredentialsWithSuccess:(void (^)(AFApplicationUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)authenticateWithSocialUserID:(NSString *)userID sourceType:(AFApplicationUserSourceType)sourceType success:(void (^)(AFApplicationUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)createUser:(AFApplicationUser *)user password:(NSString *)password success:(void (^)(AFApplicationUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)createUser:(AFApplicationUser *)user password:(NSString *)password requiresConfirmation:(BOOL)requiresConfirmation success:(void (^)(AFApplicationUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)saveUser:(AFApplicationUser *)user success:(void (^)(AFApplicationUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)saveSocialUser:(AFApplicationUser *)user success:(void (^)(AFApplicationUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)uploadPicture:(UIImage *)picture toUser:(AFApplicationUser *)user progress:(void (^)(float progress))progress completion:(void (^)(NSURL *pictureURL))completion failure:(void (^)(NSError *error))failure;

+ (void)recoverPasswordWithEmail:(NSString *)email success:(void (^)(NSString *message))success failure:(void (^)(NSError *error))failure;


@end

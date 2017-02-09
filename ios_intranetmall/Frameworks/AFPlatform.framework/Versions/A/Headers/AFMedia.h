//
//  AFMedia.h
//  Alsco
//
//  Created by Ricardo Ramos on 1/28/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <AFPlatform/AFPlatform.h>

typedef NS_ENUM(NSInteger, AFMediaType) {
    AFMediaTypeUnknown = 0,
    AFMediaTypeCollection = 1,
    AFMediaTypeImage = 2,
    AFMediaTypeVideo = 3,
    AFMediaTypeAudio = 4,
    AFMediaTypePDF = 5,
    AFMediaTypeOffice = 6,
};


@interface AFMedia : AFDictionaryModel

@property (readonly, nonatomic) NSInteger mediaID;
@property (readonly, nonatomic) NSInteger parentMediaID;
@property (readonly, nonatomic) NSString *mediaHash;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *subtitle;
@property (readonly, nonatomic) NSString *mediaTag;
@property (readonly, nonatomic) NSString *text;
@property (readonly, nonatomic) NSURL *thumbnailURL;
@property (readonly, nonatomic) CGSize thumbnailSize;
@property (readonly, nonatomic) NSURL *contentURL;
@property (readonly, nonatomic) CGSize contentSize;
@property (readonly, nonatomic) AFMediaType mediaType;

@property (readonly, nonatomic) NSArray *childMedias;
@property (readonly, nonatomic) BOOL childLoaded;

+ (void)loadRootMediasWithSuccess:(void (^)(NSArray *items))success failure:(void (^)(NSError *error))failure;
+ (void)loadMediaWithHash:(NSString *)hash success:(void (^)(AFMedia *media))success failure:(void (^)(NSError *error))failure;
+ (void)loadAllMediasWithSuccess:(void (^)(NSArray *medias))success failure:(void (^)(NSError *error))failure;

- (void)loadChildItemsWithSuccess:(void (^)(NSArray *items))success failure:(void (^)(NSError *error))failure;

@end

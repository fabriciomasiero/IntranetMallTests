//
//  AFMediaCache.h
//  heraeuskulzer
//
//  Created by Ricardo Ramos on 5/22/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface AFMediaCache : NSObject

@property (strong, nonatomic) NSString *diskCachePath;

+ (instancetype)shared;
+ (NSURL *)bestURLForItemWithURL:(NSURL *)url;

- (NSString *)defaultCachePathForKey:(NSString *)key;
- (void)syncronizeCacheWithMedias:(NSArray *)medias progressBlock:(void (^)(double progress))progressBlock completion:(void (^)())completion;

- (BOOL)diskFileExistsWithKey:(NSString *)key;
- (void)storeFileData:(NSData *)fileData forKey:(NSString *)key;
- (NSData *)diskFileDataForKey:(NSString *)key;

- (NSArray *)mediaURLsToSyncronize:(NSArray *)medias;

@end

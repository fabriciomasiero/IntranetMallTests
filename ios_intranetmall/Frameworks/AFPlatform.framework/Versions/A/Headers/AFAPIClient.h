//
//  AFAPIClient.h
//  MegaFM
//
//  Created by Ricardo Ramos on 1/15/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@interface AFAPIClient : NSObject

@property (readonly, nonatomic) NSURL *baseURL;
@property (assign, nonatomic) BOOL cacheEnabled;
@property (readonly, nonatomic) BOOL hasInternet;
@property (strong, nonatomic) NSString *cachePath;

+ (instancetype)shared;
+ (void)setBaseURL:(NSURL *)baseURL apiKey:(NSString *)apiKey;

- (void)setApplicationKey:(NSString *)applicationKey;

- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters useJsonSerialized:(BOOL)useJsonSerialized success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters useJsonSerialized:(BOOL)useJsonSerialized success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)uploadFileWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType path:(NSString *)path parameters:(NSDictionary *)parameters progress:(void (^)(float progress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)uploadFileWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType parameters:(NSDictionary *)parameters progress:(void (^)(float progress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)uploadImage:(UIImage *)image name:(NSString *)name parameters:(NSDictionary *)parameters progress:(void (^)(float progress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)uploadImages:(NSArray *)images parameters:(NSDictionary *)parameters progress:(void (^)(float progress))progress success:(void (^)(NSArray *results))success failure:(void (^)(NSError *error))failure;

@end

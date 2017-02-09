//
//  AFProjectKeyValue.h
//  RadioMegaFM
//
//  Created by Ricardo Ramos on 2/2/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import "AFDictionaryModel.h"

@interface AFProjectKeyValue : AFDictionaryModel

@property (readonly, nonatomic) NSInteger keyValueID;
@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *key;
@property (readonly, nonatomic) NSString *value;

+ (NSArray *)applicationKeyValues;
+ (NSString *)valueForKey:(NSString *)key;
+ (AFProjectKeyValue *)keyValueForKey:(NSString *)key;
+ (void)cacheMetadata;
+ (NSArray *)cachedMetadata;

+ (void)loadApplicationKeyValuesWithSuccess:(void (^)(NSArray *keyValues))success failure:(void (^)(NSError *error))failure;

@end

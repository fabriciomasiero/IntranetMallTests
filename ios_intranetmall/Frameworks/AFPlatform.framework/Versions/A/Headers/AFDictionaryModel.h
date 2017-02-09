//
//  AFDictionaryModel.h
//  Alsco
//
//  Created by Ricardo Ramos on 1/27/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFDictionaryModel : NSObject

@property (readonly, nonatomic) NSDictionary *dictionary;

+ (NSDictionary *)clearOfNullValuesWithDictionary:(NSDictionary *)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)clearOfNullValuesDictionary;

- (BOOL)containsKey:(NSString *)key;

- (NSString *)stringForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;


@end

//
//  AFHashString.h
//  AFPlatform
//
//  Created by Ricardo Ramos on 4/14/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFHashString : NSObject

- (instancetype)initWithString:(NSString *)string;

- (NSString *)md5;
- (NSString *)sha1:(NSString*)input;
- (NSString *)HMACWithKey:(NSString *)key;

+ (NSString *)md5ForString:(NSString *)string;


@end

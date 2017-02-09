//
//  AFStory.h
//  AFPlatform
//
//  Created by Ricardo Ramos on 29/06/15.
//  Copyright (c) 2015 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>

@interface AFStory : AFDictionaryModel

@property (readonly, nonatomic) NSInteger storyID;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *body;

+ (void)getStoriesWithSuccess:(void (^)(NSArray *stories))success failure:(void (^)(NSError *error))failure;

+ (void)getStoriesWithTag:(NSString *)tag success:(void (^)(NSArray *stories))success failure:(void (^)(NSError *error))failure;

@end

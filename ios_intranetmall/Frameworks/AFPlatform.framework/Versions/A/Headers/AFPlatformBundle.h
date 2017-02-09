//
//  AFPlatformBundle.h
//  AFPlatform
//
//  Created by Ricardo Ramos on 4/22/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFPlatformBundle : NSObject

@property (readonly, nonatomic) NSBundle *bundle;

+ (instancetype)shared;
- (UIImage *)imageNamed:(NSString *)imageName;

@end

//
//  AFIMLogin.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 22/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "AFSOAPRequest.h"
#import "AFSoapAPIClient.h"
#import "NSDictionary+Extras.h"
#import "AFIMShoppings.h"
#import "AFIMUser.h"

@interface AFIMLogin : AFDictionaryModel


+ (void)loginWithUserName:(NSString *)username password:(NSString *)password shopping:(AFIMShoppings *)shopping andCompletion:(void (^)(AFIMUser *user))completion failure:(void (^)(NSError *error))failure;

+ (NSDictionary *)userInfos;
+ (void)removeUserInfos;

@end

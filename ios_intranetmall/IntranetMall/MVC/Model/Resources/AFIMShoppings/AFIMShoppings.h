//
//  AFIMShoppings.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 22/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "AFSOAPRequest.h"
#import "NSDictionary+Extras.h"
#import "AFSoapAPIClient.h"


@interface AFIMShoppings : AFDictionaryModel

@property (strong, nonatomic) NSString *badge;
@property (strong, nonatomic) NSNumber *shoppingId;
@property (strong, nonatomic) NSURL *pictureUrl;
@property (strong, nonatomic) NSString *name;

+ (void)getShoppingsWithCompletion:(void (^)(NSArray *shoppings))completion failure:(void (^)(NSError *error))failure;




@end

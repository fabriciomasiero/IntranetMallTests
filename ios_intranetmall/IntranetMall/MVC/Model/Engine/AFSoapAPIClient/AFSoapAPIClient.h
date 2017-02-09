//
//  AFSoapAPIClient.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 22/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFPlatform/AFPlatform.h>

@interface AFSoapAPIClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

- (void)soapRequestWithPath:(NSString *)path withParameters:(NSArray *)parameters andCompletion:(void (^)(id response))completion failure:(void (^)(NSError *error))failure;


@end

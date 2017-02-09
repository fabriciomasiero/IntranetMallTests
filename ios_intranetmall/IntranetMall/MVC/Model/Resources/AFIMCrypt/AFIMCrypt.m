//
//  AFIMCrypt.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 30/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMCrypt.h"

@implementation AFIMCrypt




+ (void)encryptWithDocument:(NSString *)document key:(NSString *)key andCompletion:(void (^)(NSString *encryptHash))completion failure:(void (^)(NSError *error))failure {
    
    NSArray *param = @[@{AFSOAPRequestNameKey: @"textToEncrypt", AFSOAPRequestValueKey: document},
                       @{AFSOAPRequestNameKey: @"key", AFSOAPRequestValueKey: key}];
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"Encrypt" withParameters:param andCompletion:^(id response) {
        NSString *resp = response[@"text"];
        completion(resp);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)decryptTextEncrypted:(NSString *)encryptedText key:(NSString *)key andCompletion:(void (^)(NSString *decryptedHash))completion failure:(void (^)(NSError *error))failure {
    NSArray *param = @[@{AFSOAPRequestNameKey: @"textToDecrypt", AFSOAPRequestValueKey: encryptedText},
                       @{AFSOAPRequestNameKey: @"key", AFSOAPRequestValueKey: key}];
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"Decrypt" withParameters:param andCompletion:^(id response) {
        NSString *resp = response[@"text"];
        completion(resp);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end

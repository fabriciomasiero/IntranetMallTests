//
//  AFIMCrypt.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 30/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"
#import "AFSOAPRequest.h"
#import "AFSoapAPIClient.h"

@interface AFIMCrypt : AFDictionaryModel



+ (void)encryptWithDocument:(NSString *)document key:(NSString *)key andCompletion:(void (^)(NSString *encryptHash))completion failure:(void (^)(NSError *error))failure;
+ (void)decryptTextEncrypted:(NSString *)encryptedText key:(NSString *)key andCompletion:(void (^)(NSString *decryptedHash))completion failure:(void (^)(NSError *error))failure;



@end

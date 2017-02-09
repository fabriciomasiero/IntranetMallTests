//
//  NSData+Extras.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Extras)

+ (NSData *)getDataFromBase64:(NSString *)base;
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
//- (NSData *)AES128EncryptWithKey:(NSString *)key;


@end

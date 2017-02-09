//
//  AFIMCircular.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDate+Extras.h"
#import "NSDictionary+Extras.h"
#import "AFSOAPRequest.h"
#import "AFSoapAPIClient.h"
#import "AFIMUser.h"


@interface AFIMCircular : AFDictionaryModel


@property (strong, nonatomic) NSNumber *accessCount;
@property (strong, nonatomic) NSDate *registerDate;
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSNumber *circularId;
@property (strong, nonatomic) NSNumber *read;
@property (strong, nonatomic) NSURL *archiveName;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *circularReaders;
@property (nonatomic) BOOL readed;


+ (void)getCircularListWithUserId:(NSNumber *)userId shoppingId:(NSNumber *)shoppingId andCompletion:(void (^)(NSArray *circularList))completion failure:(void (^)(NSError *error))failure;

+ (void)readCircular:(NSNumber *)circularId user:(AFIMUser *)user andCompletion:(void (^)(BOOL read))completion failure:(void (^)(NSError *error))failure;



@end

//
//  AFSOAPRequest.h
//  SPDiversoes
//
//  Created by Ricardo Ramos on 11/15/12.
//  Copyright (c) 2012 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const AFSOAPRequestNameKey;
extern NSString * const AFSOAPRequestValueKey;

@interface AFSOAPRequest : NSMutableURLRequest {
@private
    NSMutableData *_responseData;
}

@property (readonly, nonatomic) NSURLConnection *connection;
@property (readonly, nonatomic) NSString *action;
@property (readonly, nonatomic) NSString *method;
@property (readonly, nonatomic) NSArray *parameters;
@property (readonly, nonatomic) NSString *soapBody;
@property (readonly, nonatomic) NSData *bodyData;

+ (AFSOAPRequest *)SOAPRequestWithURL:(NSURL *)url action:(NSString *)action method:(NSString *)method parameters:(NSArray *)parameters;
+ (void)SOAPRequestWithURL:(NSURL *)url action:(NSString *)action method:(NSString *)method parameters:(NSArray *)parameters completion:(void (^)(NSData *responseData))completion failure:(void (^)(NSError *error))failure;

- (id)initWithURL:(NSURL *)url action:(NSString *)action method:(NSString *)method parameters:(NSArray *)parameters;
- (void)startWithCompletion:(void (^)(NSData *responseData))completion failure:(void (^)(NSError *error))failure;

@end

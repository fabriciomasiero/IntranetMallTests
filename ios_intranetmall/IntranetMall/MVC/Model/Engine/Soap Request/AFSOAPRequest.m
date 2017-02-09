//
//  AFSOAPRequest.m
//  SPDiversoes
//
//  Created by Ricardo Ramos on 11/15/12.
//  Copyright (c) 2012 AppFactory. All rights reserved.
//

#import "AFSOAPRequest.h"

NSString * const AFSOAPRequestNameKey = @"AFSOAPRequestNameKey";
NSString * const AFSOAPRequestValueKey = @"AFSOAPRequestValueKey";

typedef void (^AFSOAPRequestCompletionBlock)(NSData *responseData);
typedef void (^AFSOAPRequestFailureBlock)(NSError *error);

@interface AFSOAPRequest ()

@property (readwrite, nonatomic, copy) AFSOAPRequestCompletionBlock completionBlock;
@property (readwrite, nonatomic, copy) AFSOAPRequestFailureBlock failureBlock;

- (void)configureRequest;
- (NSString *)parametersBody:(NSArray *)parameters;

@end

@implementation AFSOAPRequest

#pragma mark - NSObject

- (id)initWithURL:(NSURL *)url action:(NSString *)action method:(NSString *)method parameters:(NSArray *)parameters {
    self = [super initWithURL:url];
    if (self) {
        _action = action;
        _method = method;
        _parameters = parameters;
        
        [self configureRequest];
    }
    return self;
}

#pragma mark - Singleton

+ (AFSOAPRequest *)SOAPRequestWithURL:(NSURL *)url action:(NSString *)action method:(NSString *)method parameters:(NSArray *)parameters {
    return [[AFSOAPRequest alloc] initWithURL:url action:action method:method parameters:parameters];
}

+ (void)SOAPRequestWithURL:(NSURL *)url action:(NSString *)action method:(NSString *)method parameters:(NSArray *)parameters completion:(void (^)(NSData *responseData))completion failure:(void (^)(NSError *error))failure {
    
    AFSOAPRequest *request = [[AFSOAPRequest alloc] initWithURL:url action:action method:method parameters:parameters];
    [request startWithCompletion:completion failure:failure];
}

#pragma mark - Private

- (void)configureRequest {
    
    NSString *soapBody = @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
    <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
    <soap:Body>\
    <%@ xmlns=\"%@/\">\
    %@\
    </%@>\
    </soap:Body>\
    </soap:Envelope>";
    
    NSString *parametersString = [self parametersBody:_parameters];
    
    
    _soapBody = [NSString stringWithFormat:soapBody, _method, _action, parametersString, _method];
    
    _bodyData = [_soapBody dataUsingEncoding:NSUTF8StringEncoding];
    [self setHTTPBody:_bodyData];
    
    [self setValue:[NSString stringWithFormat:@"%@/%@", _action, _method] forHTTPHeaderField:@"SOAPAction"];
    [self setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [self setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[_bodyData length]] forHTTPHeaderField:@"Content-Length"];
    [self setHTTPMethod: @"POST"];
    
#ifdef DEBUG
    NSLog(@"[AFSOAPRequest] body: %@", _soapBody);
#endif
    
    [self setCachePolicy:NSURLRequestReloadIgnoringCacheData];
}

- (NSString *)parametersBody:(NSArray *)parameters {
    NSMutableString *body = [NSMutableString stringWithCapacity:0];
    
    [parameters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSDictionary *parameter = (NSDictionary *)obj;
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *key = parameter[AFSOAPRequestNameKey];
            NSString *value = parameter[AFSOAPRequestValueKey];
        
        
            [body appendFormat:@"<%@>%@</%@>", key, value, key];
        } else {
//            NSMutableString *b = [[NSMutableString alloc] initWithString:obj];
            [body appendString:obj];
        }
    }];
    
    return body;
}

#pragma mark - Public

- (void)startWithCompletion:(void (^)(NSData *responseData))completion failure:(void (^)(NSError *error))failure {

    _completionBlock = completion;
    _failureBlock = failure;
    
    _connection = [[NSURLConnection alloc] initWithRequest:self delegate:self startImmediately:NO];
    [_connection start];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
#ifdef DEBUG
    NSLog(@"[AFSOAPRequest] error: %@", error.localizedDescription);
#endif
    
    if (_failureBlock) {
        _failureBlock(error);
    }
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] initWithCapacity:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
#ifdef DEBUG
    NSLog(@"[AFSOAPRequest] response: %@", [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding]);
#endif
    if (_completionBlock) {
        _completionBlock(_responseData);
    }
}

@end

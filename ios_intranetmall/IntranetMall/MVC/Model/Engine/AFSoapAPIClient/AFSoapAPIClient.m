//
//  AFSoapAPIClient.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 22/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFSoapAPIClient.h"
#import "AFSOAPRequest.h"
#import <AFPlatform/AFXMLReader.h>


#define BASE_URL @"http://im.intranetmall.com.br/WsApp/WebService.asmx"


@implementation AFSoapAPIClient


+ (instancetype)sharedClient {
    static AFSoapAPIClient *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[AFSoapAPIClient alloc] init];
    });
    return _shared;
}

#pragma mark - NSObject

- (id)init {
    NSURL *baseURL = [NSURL URLWithString:BASE_URL];
    self = [super initWithBaseURL:baseURL];
    if (self) {
        [self setResponseSerializer:[AFXMLParserResponseSerializer serializer]];
    }
    return self;
}



- (void)soapRequestWithPath:(NSString *)path withParameters:(NSArray *)parameters andCompletion:(void (^)(id response))completion failure:(void (^)(NSError *error))failure {
    
//    NSArray *param = [[NSArray alloc] initWithObjects:parameters, nil];
    
    
    [AFSOAPRequest SOAPRequestWithURL:[NSURL URLWithString:BASE_URL] action:@"https://im.intranetmall.com.br/WsApp" method:path parameters:parameters completion:^(NSData *responseData) {
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [AFXMLReader dictionaryForXMLData:responseData error:&parseError];
        if (parseError) {
            if (failure) {
                failure(parseError);
            }
        } else {
            
            
            NSDictionary *envelope = responseDictionary[@"soap:Envelope"];
            NSDictionary *body = envelope[@"soap:Body"];
            NSString *responseStringKey = [path stringByAppendingString:@"Response"];
            NSDictionary *response = body[responseStringKey];
            if (response) {
                NSString *resultStringKey = [path stringByAppendingString:@"Result"];
                NSDictionary *result = response[resultStringKey];

                completion(result);
            } else {
                NSMutableDictionary *details = [NSMutableDictionary dictionary];
                [details setValue:[self getErrorValue:body[@"soap:Fault"]] forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:@"Error" code:200 userInfo:details];
                failure(error);
            }
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (NSString *)getErrorValue:(NSDictionary *)dic {
    NSDictionary *d = dic[@"faultstring"];
    return d[@"text"];
}

@end

//
//  AFIMLogin.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 22/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMLogin.h"

@implementation AFIMLogin


+ (void)loginWithUserName:(NSString *)username password:(NSString *)password shopping:(AFIMShoppings *)shopping andCompletion:(void (^)(AFIMUser *user))completion failure:(void (^)(NSError *error))failure {
    
    NSArray *param = @[@{AFSOAPRequestNameKey: @"usuario", AFSOAPRequestValueKey: username},
                     @{AFSOAPRequestNameKey: @"senha", AFSOAPRequestValueKey: password},
                     @{AFSOAPRequestNameKey: @"idShopping", AFSOAPRequestValueKey: shopping.shoppingId}];
    
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"AutenticaUsuario" withParameters:param andCompletion:^(id response) {
        NSDictionary *dic = response;
        if ([dic containsKey:@"usuario"]) {
            NSDictionary *dicError = dic[@"usuario"];
            if ([dicError containsKey:@"descricaoErro"]) {
                NSMutableDictionary *details = [NSMutableDictionary dictionary];
                [details setValue:[self getValue:dicError[@"descricaoErro"]] forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:@"Error" code:200 userInfo:details];
                failure(error);
            } else {
                [[NSUserDefaults standardUserDefaults] setObject:shopping.shoppingId forKey:@"shoppingId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                AFIMUser *user = [[AFIMUser alloc] initWithDictionary:response];
                [user setShoppingId:shopping.shoppingId];
                NSLog(@"user :%@", user);
                completion(user);
            }
        } else {
            
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}



+ (NSDictionary *)userInfos {
    
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    NSNumber *shoppingId = [[NSUserDefaults standardUserDefaults] objectForKey:@"shoppingId"];
    if (user && password && shoppingId) {
        return @{@"login" : user, @"password" : password, @"shoppingId" : shoppingId};
    }
    return nil;
}
+ (void)removeUserInfos {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shoppingId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getValue:(NSDictionary *)dic {
    if ([dic containsKey:@"text"]) {
        return [NSString stringWithFormat:@"%@", dic[@"text"]];
    } else {
        return @"";
    }
}

@end

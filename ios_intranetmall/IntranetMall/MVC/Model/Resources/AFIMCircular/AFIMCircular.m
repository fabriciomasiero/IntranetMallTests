//
//  AFIMCircular.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMCircular.h"
#import "AFIMCircularReaders.h"
#import "AFDatabaseManager.h"
#import "Circular+CoreDataClass.h"
#import "AppDelegate.h"

@implementation AFIMCircular

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
//        NSDictionary *circular = dictionary[@"circulares"];
//        NSDictionary *readers = dictionary[@"leitores"];
        
//        NSDictionary *dicCircular = circular[@"circular"];
        
        
        if ([dictionary containsKey:@"acessos"]) {
            _accessCount = [self getNumberValue:dictionary[@"acessos"]];
        }
        
        if ([dictionary containsKey:@"data_cad"]) {
            _registerDate = [self getDateValue:dictionary[@"data_cad"]];
        }
        
        if ([dictionary containsKey:@"idUser"]) {
            _userId = [self getNumberValue:dictionary[@"idUser"]];
        }
        
        if ([dictionary containsKey:@"idcircular"]) {
            _circularId = [self getNumberValue:dictionary[@"idcircular"]];
        }
        
        if ([dictionary containsKey:@"leitura"]) {
            _read = [self getNumberValue:dictionary[@"leitura"]];
        }
        
        if ([dictionary containsKey:@"nomearquivo"]) {
            _archiveName = [self getUrlValue:dictionary[@"nomearquivo"]];
        }
        
        if ([dictionary containsKey:@"titulo"]) {
            _title = [self getValue:dictionary[@"titulo"]];
        }
        
        NSMutableArray *mutableReaders = [[NSMutableArray alloc] init];
        
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        if (appDelegate.user) {
            
        }
        
        if ([dictionary[@"buscaLidas"] isKindOfClass:[NSDictionary class]]) {
            [mutableReaders addObject:[[AFIMCircularReaders alloc] initWithDictionary:dictionary[@"buscaLidas"]]];
        } else {
            for (NSDictionary *d in dictionary[@"buscaLidas"]) {
                AFIMCircularReaders *reader = [[AFIMCircularReaders alloc] initWithDictionary:d];
                [mutableReaders addObject:reader];
            }
        }
        _circularReaders = [NSArray arrayWithArray:[mutableReaders mutableCopy]];
        
        Circular *thisCircular = [[AFDatabaseManager sharedManager] createCircular:self];
        if (thisCircular) {
            [[AFDatabaseManager sharedManager] insertReaders:_circularReaders inCircular:thisCircular];
        }
    }
    return self;
}


- (NSString *)getValue:(NSDictionary *)dic {
    if ([dic containsKey:@"text"]) {
        return [NSString stringWithFormat:@"%@", dic[@"text"]];
    } else {
        return @"";
    }
}
- (NSNumber *)getNumberValue:(NSDictionary *)dic {
    return @([[self getValue:dic] integerValue]);
}

- (NSDate *)getDateValue:(NSDictionary *)dic {
    NSString *value = [self getValue:dic];
    return [NSDate dateFromString:value];
}
- (NSURL *)getUrlValue:(NSDictionary *)dic {
    return [NSURL URLWithString:[self getValue:dic]];
}


+ (void)getCircularListWithUserId:(NSNumber *)userId shoppingId:(NSNumber *)shoppingId andCompletion:(void (^)(NSArray *circularList))completion failure:(void (^)(NSError *error))failure {
    NSArray *param = @[@{AFSOAPRequestNameKey: @"idUsuario", AFSOAPRequestValueKey: userId},
                       @{AFSOAPRequestNameKey: @"idShopping", AFSOAPRequestValueKey: shoppingId}];
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"ListaCircularLeitura" withParameters:param andCompletion:^(id response) {
        
        NSMutableArray *mutableResp = [[NSMutableArray alloc] init];
        if ([response count] > 0) {
            NSDictionary *circularDic = response[@"circulares"];
            NSArray *resp = circularDic[@"circular"];
            if ([resp isKindOfClass:[NSDictionary class]]) {
                resp = @[circularDic[@"circular"]];
            }
            
            for (NSDictionary *d in resp) {
                [mutableResp addObject:[[AFIMCircular alloc] initWithDictionary:d]];
            }
        }
        NSArray *allCircular = [Circular all];
        completion(allCircular);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
+ (void)readCircular:(NSNumber *)circularId user:(AFIMUser *)user andCompletion:(void (^)(BOOL read))completion failure:(void (^)(NSError *error))failure {
    NSArray *param = @[@{AFSOAPRequestNameKey: @"idUsuario", AFSOAPRequestValueKey: user.userId},
                       @{AFSOAPRequestNameKey: @"idShopping", AFSOAPRequestValueKey: user.shoppingId},
                       @{AFSOAPRequestNameKey: @"idCircular", AFSOAPRequestValueKey: circularId}];
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"ControleCircular" withParameters:param andCompletion:^(id response) {
        
        NSDictionary *dic = response[@"leitura"];
        NSNumber *numberValue;
        if ([dic containsKey:@"text"]) {
            numberValue = @([[NSString stringWithFormat:@"%@", dic[@"text"]] integerValue]);
        } else {
            numberValue = @(0);
        }
        
        
        BOOL value;
        if ([numberValue isEqualToNumber:@(0)]) {
            value = NO;
        } else if ([numberValue isEqualToNumber:@(1)]) {
            value = YES;
        } else {
            value = NO;
        }
        
        completion(value);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end

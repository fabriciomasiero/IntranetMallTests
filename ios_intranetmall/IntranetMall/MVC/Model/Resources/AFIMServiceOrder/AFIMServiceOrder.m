//
//  AFIMServiceOrder.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrder.h"
#import "AFIMServiceOrderApprovers.h"
#import "AFIMServiceOrderAuthorizedUsers.h"
#import "AFDatabaseManager.h"
#import "AFIMServiceOrderObservations.h"
#import "AFIMServiceOrderStatus.h"

@implementation AFIMServiceOrder

- (id)initWithDictionary:(NSDictionary *)dictionary saveCoreData:(BOOL)saveCoreData {
    if (self) {
        if ([dictionary containsKey:@"id"]) {
            _serviceOrderId = [self getNumberValue:dictionary[@"id"]];
        }
        if ([dictionary containsKey:@"iduser"]) {
            _userId = [self getNumberValue:dictionary[@"iduser"]];
        }
        if ([dictionary containsKey:@"empresa"]) {
            _enterprise = [self getValue:dictionary[@"empresa"]];
        }
        if ([dictionary containsKey:@"LUC"]) {
            _luc = [self getValue:dictionary[@"LUC"]];
        }
        if ([dictionary containsKey:@"idtipo"]) {
            _typeId = [self getNumberValue:dictionary[@"idtipo"]];
        }
        if ([dictionary containsKey:@"datacad"]) {
            _registerDate = [self getDateValue:dictionary[@"datacad"]];
        }
        if ([dictionary containsKey:@"horacad"]) {
            _registerHour = [self getDateHourValue:dictionary[@"horacad"]];
        }
        if ([dictionary containsKey:@"datainicio"]) {
            _initialDate = [self getDateValue:dictionary[@"datainicio"]];
        }
        if ([dictionary containsKey:@"horainicio"]) {
            _initialHour = [self getDateHourValue:dictionary[@"horainicio"]];
        }
        if ([dictionary containsKey:@"datafim"]) {
            _finalDate = [self getDateValue:dictionary[@"datafim"]];
        }
        if ([dictionary containsKey:@"horafim"]) {
            _finalHour = [self getDateHourValue:dictionary[@"horafim"]];
        }
        if ([dictionary containsKey:@"idstatus"]) {
            _statusId = [self getNumberValue:dictionary[@"idstatus"]];
        }
        if ([dictionary containsKey:@"nomelojista"]) {
            _shopkeeperName = [self getValue:dictionary[@"nomelojista"]];
        }
        if ([dictionary containsKey:@"solicitante"]) {
            _requesterName = [self getValue:dictionary[@"solicitante"]];
        }
        if ([dictionary containsKey:@"telefone"]) {
            _phone = [self getValue:dictionary[@"telefone"]];
        }
        if ([dictionary containsKey:@"email"]) {
            _email = [self getValue:dictionary[@"email"]];
        }
        if ([dictionary containsKey:@"descricao"]) {
            _serviceOrderDescription = [self getValue:dictionary[@"descricao"]];
        }
        if ([dictionary containsKey:@"inicial"]) {
            _initialDateHour = [self getDateValue:dictionary[@"inicial"]];
        }
        if ([dictionary containsKey:@"final"]) {
            _finalDateHour = [self getDateValue:dictionary[@"final"]];
        }
        if ([dictionary containsKey:@"iddestino"]) {
            _destinationId = [self getNumberValue:dictionary[@"iddestino"]];
        }
        //        if ([dictionary containsKey:@"observacoes"]) {
        //            _observations = [self getValue:dictionary[@"observacoes"]];
        //        }
        if ([dictionary containsKey:@"status"]) {
            _status = [self getValue:dictionary[@"status"]];
        }
        
        _synced = NO;
        
        
        if (_status.length == 0) {
            _status = @"";
        }
        if (_luc.length == 0) {
            _luc = @"";
        }
        if (_enterprise.length == 0) {
            _enterprise = @"";
        }
        
        if (_statusId == nil || [_statusId isEqualToNumber:@(0)]) {
            _statusId = @(1);
        }
        _imgNameStatus = [self getImageNameByStatus:[_statusId integerValue]];
        
        _serviceType = @"";
        UserServiceType *serviceType = [UserServiceType find:@"typeId == %@", _typeId];
        if (serviceType) {
            _serviceType = serviceType.serviceDescription;
        }
        if (_serviceType.length < 1) {
            _serviceType = @"";
        }
        ServiceOrder *serviceOrder;
        if (saveCoreData) {
            serviceOrder = [[AFDatabaseManager sharedManager] createServiceOrder:self];
        }
        
        _approvers = [self getApprovers:dictionary andServiceOrder:serviceOrder];
        _authorizedUsers = [self getAuthorizedUsers:dictionary andServiceOrder:serviceOrder];
        _files = [self getFiles:dictionary andServiceOrder:serviceOrder];
        _observations = [self getObservations:dictionary andServiceOrder:serviceOrder];
        
        if ([dictionary containsKey:@"usuariodestino"]) {
            NSDictionary *destinationDic = dictionary[@"usuariodestino"];
            _userDestination = [[AFIMServiceOrderDestinationUser alloc] initWithDictionary:destinationDic andServiceOrder:serviceOrder];
        }
    }
    return self;
}

#pragma mark - NSDictiobary Infos
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
- (NSDate *)getDateHourValue:(NSDictionary *)dic {
    NSString *value = [self getValue:dic];
    return [NSDate dateHourFromString:value];
}

#pragma mark - Get Status
- (NSString *)getImageNameByStatus:(NSInteger)statusId {
    NSString *imgName = @"";
    switch (statusId) {
        case 0:
            imgName = @"";
            break;
        case 1:
            imgName = @"imgInApproval";
            break;
        case 2:
            imgName = @"imgAuthorized";
            break;
        case 3:
            imgName = @"imgNotAuthorized";
            break;
        case 4:
            imgName = @"imgInExecution";
            break;
        case 5:
            imgName = @"imgCompleted";
            break;
        case 6:
            imgName = @"imgExpired";
            break;
        default:
            break;
    }
    
    return imgName;
}
#pragma mark - Get Status
+ (NSString *)getStatusFromService:(NSInteger)statusId {
    NSString *statusName = @"";
    switch (statusId) {
        case 0:
            statusName = @"Sem Status";
            break;
        case 1:
            statusName = @"Em Aprovação";
            break;
        case 2:
            statusName = @"Autorizado";
            break;
        case 3:
            statusName = @"Não Autorizado";
            break;
        case 4:
            statusName = @"Em Execução";
            break;
        case 5:
            statusName = @"Concluído";
            break;
        case 6:
            statusName = @"Expirado";
            break;
        default:
            break;
    }
    return statusName;
}
+ (NSArray *)getStatusList {
    NSMutableArray *mutableList = [[NSMutableArray alloc] init];
    for (int i = 1; i < 7; i++) {
        [mutableList addObject:[[AFIMServiceOrderStatus alloc] initWithTitle:[self getStatusFromService:i] statusId:i]];
    }
    return [NSArray arrayWithArray:[mutableList mutableCopy]];
}

#pragma mark - Get For Model Organization

- (NSArray *)getApprovers:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder {
    if ([dictionary containsKey:@"listaaprovadores"]) {
        NSMutableArray *mutableApprovers = [[NSMutableArray alloc] init];
        NSDictionary *approversListDic = dictionary[@"listaaprovadores"];
        if ([approversListDic containsKey:@"aprovadores"]) {
            id approversList = approversListDic[@"aprovadores"];
            if ([approversList isKindOfClass:[NSArray class]]) {
                for (NSDictionary *d in approversList) {
                    [mutableApprovers addObject:[[AFIMServiceOrderApprovers alloc] initWithDictionary:d andServiceOrder:serviceOrder]];
                }
            } else {
                [mutableApprovers addObject:[[AFIMServiceOrderApprovers alloc] initWithDictionary:approversList andServiceOrder:serviceOrder]];
            }
        }
        return [NSArray arrayWithArray:[mutableApprovers mutableCopy]];
    }
    return @[];
}
- (NSArray *)getAuthorizedUsers:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder {
    if ([dictionary containsKey:@"listapessoasautorizadas"]) {
        NSMutableArray *mutableApprovers = [[NSMutableArray alloc] init];
        NSDictionary *approversListDic = dictionary[@"listapessoasautorizadas"];
        if ([approversListDic containsKey:@"pessoasAutorizadas"]) {
            id approversList = approversListDic[@"pessoasAutorizadas"];
            if ([approversList isKindOfClass:[NSArray class]]) {
                for (NSDictionary *d in approversList) {
                    [mutableApprovers addObject:[[AFIMServiceOrderAuthorizedUsers alloc] initWithDictionary:d andServiceOrder:serviceOrder]];
                }
            } else {
                [mutableApprovers addObject:[[AFIMServiceOrderAuthorizedUsers alloc] initWithDictionary:approversList andServiceOrder:serviceOrder]];
            }
        }
        return [NSArray arrayWithArray:[mutableApprovers mutableCopy]];
    }
    return @[];
}
- (NSArray *)getFiles:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder {
    if ([dictionary containsKey:@"listaUrlFile"]) {
        NSMutableArray *mutableApprovers = [[NSMutableArray alloc] init];
        NSDictionary *approversListDic = dictionary[@"listaUrlFile"];
        if ([approversListDic containsKey:@"urlfile"]) {
            id approversList = approversListDic[@"urlfile"];
            if ([approversList isKindOfClass:[NSArray class]]) {
                for (NSDictionary *d in approversList) {
                    [mutableApprovers addObject:[[AFIMServiceOrderFile alloc] initWithDictionary:d andServiceOrder:serviceOrder]];
                }
            } else {
                [mutableApprovers addObject:[[AFIMServiceOrderFile alloc] initWithDictionary:approversList andServiceOrder:serviceOrder]];
            }
        }
        return [NSArray arrayWithArray:[mutableApprovers mutableCopy]];
    }
    return @[];
}
- (NSArray *)getObservations:(NSDictionary *)dictionary andServiceOrder:(ServiceOrder *)serviceOrder {
    if ([dictionary containsKey:@"listaobs"]) {
        NSMutableArray *mutableObservations = [[NSMutableArray alloc] init];
        NSDictionary *observationsListDic = dictionary[@"listaobs"];
        if ([observationsListDic containsKey:@"observacao"]) {
            id observationList = observationsListDic[@"observacao"];
            if ([observationList isKindOfClass:[NSArray class]]) {
                for (NSDictionary *d in observationList) {
                    [mutableObservations addObject:[[AFIMServiceOrderObservations alloc] initWithDictionary:d andServiceOrder:serviceOrder]];
                }
            } else {
                [mutableObservations addObject:[[AFIMServiceOrderObservations alloc] initWithDictionary:observationList andServiceOrder:serviceOrder]];
            }
        }
        return [NSArray arrayWithArray:[mutableObservations mutableCopy]];
    }
    return @[];
}


#pragma mark - Get to Param
+ (NSString *)getFilesParameters:(NSArray *)files {
    NSString *str = @"";
    for (AFFile *f in files) {
        NSString *newStr = @"";
        
        newStr = [NSString stringWithFormat:@"<Arquivos><extensao>%@</extensao><file>%@</file></Arquivos>", f.fileExtension, f.fileEncoded];
        str = [NSString stringWithFormat:@"%@%@", str, newStr];
    }
    return str;
}
+ (NSString *)getAuthorizedUsers:(NSArray *)authorizedUsers {
    NSString *str = @"";
    for (AFIMNewServiceOrderAuthorizedUsers *a in authorizedUsers) {
        NSString *newStr = @"";
        newStr = [NSString stringWithFormat:@"<PAutorizadas><nome>%@</nome><rg>%@</rg><empresa>%@</empresa></PAutorizadas>", a.user.name, a.user.documentInsideCountry, a.user.enterprise];
        str = [NSString stringWithFormat:@"%@%@", str, newStr];
        
    }
    return str;
}
+ (NSString *)getServicesConsultParameters:(NSArray *)services {
    NSString *str = @"";
    for (id f in services) {
        AFIMServiceOrderConsultService *service = (AFIMServiceOrderConsultService *)f;
        
        if (![service.value isKindOfClass:[NSString class]]) {
            if ([service.value isKindOfClass:[AFIMServiceOrderStatus class]]) {
                NSString *newStr = @"";
                AFIMServiceOrderStatus *status = (AFIMServiceOrderStatus *)service.value;
                newStr = [NSString stringWithFormat:@"<idservico><int>%@</int></idservico>", @(status.statusId)];
                str = [NSString stringWithFormat:@"%@%@", str, newStr];
            } else {
                NSString *newStr = @"";
                UserServiceType *type = (UserServiceType *)service.value;
                newStr = [NSString stringWithFormat:@"<idtiposervico><int>%@</int></idtiposervico>", @(type.typeId)];
                str = [NSString stringWithFormat:@"%@%@", str, newStr];
            }
        }
    }
    return str;
}



#pragma mark - APICAllout
+ (void)getServiceOrdersWithUserId:(NSNumber *)userId shoppingId:(NSNumber *)shoppingId userType:(NSNumber *)userType andCompletion:(void (^)(NSArray *serviceOrderList))completion failure:(void (^)(NSError *error))failure {
    NSArray *param = @[@{AFSOAPRequestNameKey: @"idUser", AFSOAPRequestValueKey: userId},
                       @{AFSOAPRequestNameKey: @"idShopping", AFSOAPRequestValueKey: shoppingId},
                       @{AFSOAPRequestNameKey: @"tipo", AFSOAPRequestValueKey: userType}];
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"Lista_Os" withParameters:param andCompletion:^(id response) {
        NSMutableArray *mutableResp = [[NSMutableArray alloc] init];
        [ServiceOrderFile deleteAll];
        [ServiceOrderApprover deleteAll];
        [ServiceOrderObservations deleteAll];
        [ServiceOrderAuthorizedUser deleteAll];
        if ([response count] > 0) {
            id resp = [response[@"listas"] objectForKey:@"listaOS"];
            if ([resp isKindOfClass:[NSDictionary class]]) {
                [mutableResp addObject:[[AFIMServiceOrder alloc] initWithDictionary:resp saveCoreData:YES]];
            } else {
                for (NSDictionary *d in resp) {
                    [mutableResp addObject:[[AFIMServiceOrder alloc] initWithDictionary:d saveCoreData:YES]];
                }
            }
        }
        NSArray *allServiceOrders = [[AFDatabaseManager sharedManager] getRecentServiceOrders];
        completion(allServiceOrders);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
+ (void)saveServiceOrder:(AFIMNewServiceOrder *)serviceOrder andCompletion:(void (^)(AFIMServiceOrder *newServiceOrder))completion failure:(void (^)(NSError *error))failure {
    
    NSString *files = [self getFilesParameters:serviceOrder.files];
    NSString *authorizedUsers = [self getAuthorizedUsers:serviceOrder.users];
    
    NSString *str = [NSString stringWithFormat:@"<idShopping>%@</idShopping>"
                     @"<iduser>%@</iduser>"
                     @"<idtipo>%@</idtipo>"
                     @"<datainicio>%@</datainicio>"
                     @"<datafim>%@</datafim>"
                     @"<horainicio>%@</horainicio>"
                     @"<horafim>%@</horafim>"
                     @"<nomelojista>%@</nomelojista>"
                     @"<nomesolicita>%@</nomesolicita>"
                     @"<telefone>%@</telefone>"
                     @"<email>%@</email>"
                     @"<descricao>%@</descricao>"
                     @"<iddestino>%@</iddestino>"
                     @"<descricaotipo>%@</descricaotipo>"
                     @"<Arquivos_>%@</Arquivos_>"
                     @"<Pessoas_>%@</Pessoas_>", serviceOrder.loggedUser.shoppingId,
                     serviceOrder.loggedUser.userId,
                     @(serviceOrder.serviceType.typeId),
                     serviceOrder.initialDate,
                     serviceOrder.finalDate,
                     serviceOrder.initialHour,
                     serviceOrder.finalHour,
                     serviceOrder.loggedUser.username,
                     serviceOrder.requesterName,
                     serviceOrder.loggedUser.phone,
                     serviceOrder.loggedUser.email,
                     serviceOrder.serviceOrderDescription,
                     serviceOrder.loggedUser.userId,
                     serviceOrder.serviceType.serviceDescription,
                     files,
                     authorizedUsers];
    
    
    NSArray *dict = @[@{AFSOAPRequestNameKey: @"Ordem", AFSOAPRequestValueKey: str}];
    
    
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"GravaOrdem" withParameters:dict andCompletion:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            completion([[AFIMServiceOrder alloc] initWithDictionary:response saveCoreData:YES]);
        }
        if (!response) {
            NSMutableDictionary *details = [NSMutableDictionary dictionary];
            [details setValue:@"Erro no cadastro da ordem de serviço" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"Error" code:200 userInfo:details];
            failure(error);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)approveServiceOrder:(ServiceOrder *)serviceOrder user:(AFIMUser *)user observationText:(NSString *)observationText approvalStatus:(AFIMServiceOrderApprovalStatus)status andCompletion:(void (^)(AFIMServiceOrderApproved *serviceOrderApproved))completion failure:(void (^)(NSError *error))failure {
    
    NSArray *param = @[@{AFSOAPRequestNameKey: @"idUsuario", AFSOAPRequestValueKey: user.userId},
                       @{AFSOAPRequestNameKey: @"idOs", AFSOAPRequestValueKey: @(serviceOrder.serviceOrderId)},
                       @{AFSOAPRequestNameKey: @"idShopping", AFSOAPRequestValueKey: user.shoppingId},
                       @{AFSOAPRequestNameKey: @"obs", AFSOAPRequestValueKey: observationText},
                       @{AFSOAPRequestNameKey: @"aprovacao", AFSOAPRequestValueKey: @(status)}];
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"GravaObsOs" withParameters:param andCompletion:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            completion([[AFIMServiceOrderApproved alloc] initWithDictionary:response]);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
+ (void)consultServiceOrder:(AFIMServiceOrderConsult *)serviceOrderConsult withServices:(NSArray *)servicesStatus servicesTypes:(NSArray *)servicesTypes user:(AFIMUser *)user andCompletion:(void (^)(NSArray *serviceOrders))completion failure:(void (^)(NSError *error))failure {

    
    NSString *servicesStatusInfo = [self getServicesConsultParameters:servicesStatus];
    NSString *servicesInfo = [self getServicesConsultParameters:servicesTypes];
    
    
    NSString *str = [NSString stringWithFormat:@"<idShopping>%@</idShopping>"
                     @"<idUser>%@</idUser>"
                     @"<datainicial>%@</datainicial>"
                     @"<datafinal>%@</datafinal>"
                     @"<listastatusservico>%@</listastatusservico>"
                     @"<listatiposervico>%@</listatiposervico>",
                     user.shoppingId,
                     user.userId,
                     [NSString stringGetDayDateUsDate:serviceOrderConsult.date],
                     [NSString stringGetDayDateUsDate:serviceOrderConsult.hour],
                     servicesStatusInfo,
                     servicesInfo];
    
    NSArray *dict = @[str];
                     
    
    [[AFSoapAPIClient sharedClient] soapRequestWithPath:@"Lista_Os_Filtro" withParameters:dict andCompletion:^(id response) {
        NSMutableArray *mutableResp = [[NSMutableArray alloc] init];
        if ([response count] > 0) {
            id resp = [response[@"listas"] objectForKey:@"listaOS"];
            if ([resp isKindOfClass:[NSDictionary class]]) {
                [mutableResp addObject:[[AFIMServiceOrder alloc] initWithDictionary:resp saveCoreData:NO]];
            } else {
                for (NSDictionary *d in resp) {
                    [mutableResp addObject:[[AFIMServiceOrder alloc] initWithDictionary:d saveCoreData:NO]];
                }
            }
        }
        NSArray *resp = [NSArray arrayWithArray:[mutableResp mutableCopy]];
        completion(resp);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end

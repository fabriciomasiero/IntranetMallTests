//
//  AFIMNewServiceOrder.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMNewServiceOrder.h"

@implementation AFIMNewServiceOrder

- (id)initWithInitialDate:(NSDate *)initialDate finalDate:(NSDate *)finalDate initialHour:(NSDate *)initialHour finalHour:(NSDate *)finalHour userSector:(UserSector *)userSector userServiceType:(UserServiceType *)serviceType {
    if (self) {
        _initialDate = initialDate;
        _finalDate = finalDate;
        _initialHour = initialHour;
        _finalHour = finalHour;
        _userSector = userSector;
        _serviceType = serviceType;
    }
    return self;
}
- (BOOL)serviceOrderIsNull {
    if (_initialDate == nil && _finalDate == nil && _initialHour == nil && _finalHour == nil && _userSector == nil && _serviceType == nil) {
        return YES;
    }
    return NO;
}
- (NSDictionary *)serviceIncompleted {
    if (_initialDate == nil) {
        return @{@"alert" : @"Data inicial não foi inserida corretamente", @"type" : @(AFIMNewServiceOrderTypeInitialDate)};
    } else if (_finalDate == nil) {
        return @{@"alert" : @"Data final não foi inserida corretamente", @"type" : @(AFIMNewServiceOrderTypeFinalDate)};
    } else if (_initialHour == nil) {
        return @{@"alert" : @"Hora inicial não foi inserida corretamente", @"type" : @(AFIMNewServiceOrderTypeInitialHour)};
    } else if (_finalHour == nil) {
        return @{@"alert" : @"Hora final não foi inserida corretamente", @"type" : @(AFIMNewServiceOrderTypeFinalHour)};
    } else if (_userSector == nil || _serviceType == nil) {
        return @{@"alert" : @"Não foi escolhido um tipo de OS", @"type" : @(AFIMNewServiceOrderTypeType)};
    }
    return nil;
}
- (NSDictionary *)serviceDetailIncompleted {
    
    if (_serviceOrderDescription == nil || _serviceOrderDescription.length <= 1) {
        return @{@"alert" : @"Não foi inserido a descrição da ordem de serviço", @"type" : @(AFIMNewServiceOrderTypeDescription)};
    } else if (_requesterName == nil || _requesterName.length <= 1) {
        return @{@"alert" : @"É necessário inserir um nome de solicitante", @"type" : @(AFIMNewServiceOrderTypeRequester)};
    } else if (_users == nil || [_users count] == 0) {
        return @{@"alert" : @"Usuários não foram inclusos", @"type" : @(AFIMNewServiceOrderTypeUsers)};
    } else if (_files == nil || [_files count] == 0) {
        return @{@"alert" : @"Arquivos não foram inclusos", @"type" : @(AFIMNewServiceOrderTypeFiles)};
    }
    return nil;
}

- (NSString *)textForItem:(NSString *)s {
    if (s.length > 2) {
        return s;
    }
    return @"alterar";
}


@end

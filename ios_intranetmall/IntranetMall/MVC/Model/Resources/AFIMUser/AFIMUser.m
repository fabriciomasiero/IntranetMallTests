//
//  AFIMUser.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 23/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMUser.h"
#import "AFIMUserCalendar.h"

@implementation AFIMUser

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        
        NSDictionary *dicCalendar = dictionary[@"calendario"];
        NSArray *calendars = dicCalendar[@"Calendario"];
        
        NSMutableArray *mutableCalendars = [[NSMutableArray alloc] init];
        
        for (NSDictionary *c in calendars) {
            [mutableCalendars addObject:[[AFIMUserCalendar alloc] initWithDictionary:c]];
        }
        _calendars = [NSArray arrayWithArray:[mutableCalendars mutableCopy]];
        
        NSDictionary *dicCarrousel = dictionary[@"carrossel"];
        NSArray *carrousels = dicCarrousel[@"imgCarrousel"];
        
        NSMutableArray *mutableCarrousels = [[NSMutableArray alloc] init];
        
        for (NSDictionary *c in carrousels) {
            [mutableCarrousels addObject:[[AFIMUserCarrousel alloc] initWithDictionary:c]];
        }
        
        _carrousels = [NSArray arrayWithArray:[mutableCarrousels mutableCopy]];
        
        _device = [[AFIMUserDevice alloc] initWithDictionary:dictionary[@"device"]];
        
        _home = [[AFIMUserHome alloc] initWithDictionary:dictionary[@"home"]];
        
        
        NSDictionary *dicSector = dictionary[@"listsetor"];
        NSArray *sectors = dicSector[@"setorCs"];
        
        
        NSMutableArray *mutableSectors = [[NSMutableArray alloc] init];
        
        for (NSDictionary *s in sectors) {
            [mutableSectors addObject:[[AFIMUserSector alloc] initWithDictionary:s]];
        }
        
        _sectors = [NSArray arrayWithArray:[mutableSectors mutableCopy]];
        
        
        
        NSDictionary *dicUser = dictionary[@"usuario"];
        
        
        
        
        
        
        
        if ([dicUser containsKey:@"acesso"]) {
            _access = [self getValue:dicUser[@"acesso"]];
        }
        if ([dicUser containsKey:@"contrato"]) {
            _contract = [self getValue:dicUser[@"contrato"]];
        }
        if ([dicUser containsKey:@"datacesso"]) {
//            _accessDate
        }
        if ([dicUser containsKey:@"depto"]) {
            _department = [self getValue:dicUser[@"depto"]];
        }
        if ([dicUser containsKey:@"emailUser"]) {
            _email = [self getValue:dicUser[@"emailUser"]];
        }
        if ([dicUser containsKey:@"emailUser2"]) {
            _otherEmail = [self getValue:dicUser[@"emailUser2"]];
        }
        if ([dicUser containsKey:@"empresa"]) {
            _company = [self getValue:dicUser[@"empresa"]];
        }
        if ([dicUser containsKey:@"horaacesso"]) {
//            _accessHour
        }
        if ([dicUser containsKey:@"idUser"]) {
            _userId = @([[self getValue:dicUser[@"idUser"]] integerValue]);
        }
        if ([dicUser containsKey:@"id_cracha_tipo"]) {
            _badgeTypeId = @([[self getValue:dicUser[@"id_cracha_tipo"]] integerValue]);
        }
        if ([dicUser containsKey:@"imgShopp"]) {
            _shopData64 = [self getValue:dicUser[@"imgShopp"]];
        }
        if ([dicUser containsKey:@"login"]) {
            _login = [self getValue:dicUser[@"login"]];
        }
        if ([dicUser containsKey:@"luc"]) {
            _luc = [self getValue:dicUser[@"luc"]];
        }
        if ([dicUser containsKey:@"nomeShopping"]) {
            _shoppingName = [self getValue:dicUser[@"nomeShopping"]];
        }
        if ([dicUser containsKey:@"nomeUser"]) {
            _username = [self getValue:dicUser[@"nomeUser"]];
        }
        if ([dicUser containsKey:@"senha"]) {
            _password = [self getValue:dicUser[@"senha"]];
        }
        if ([dicUser containsKey:@"piso"]) {
            _floor = [self getValue:dicUser[@"piso"]];
        }
        if ([dicUser containsKey:@"primeiroacesso"]) {
            _firstAccess = @([[self getValue:dicUser[@"primeiroacesso"]] integerValue]);
        }
        if ([dicUser containsKey:@"rsocial"]) {
            _social = [self getValue:dicUser[@"rsocial"]];
        }
        if ([dicUser containsKey:@"telefone"]) {
            _phone = [self getValue:dicUser[@"telefone"]];
        }
        if ([dicUser containsKey:@"tipoUser"]) {
            _userType = @([[self getValue:dicUser[@"tipoUser"]] integerValue]);
        }
        
        [self saveUser];
        
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

- (void)saveUser {
    [[NSUserDefaults standardUserDefaults] setObject:_login forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:_password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSString *)getObjectWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
- (NSInteger)getIntegerObjectWithKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}
- (void)removeObjectWithKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isAdmin {
    if ([self.userType isEqualToNumber:@(1)]) {
        return YES;
    } else {
        return NO;
    }
}

@end

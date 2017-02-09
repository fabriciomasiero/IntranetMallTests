//
//  AFDatabaseManager.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 14/12/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFDatabaseManager.h"

@implementation AFDatabaseManager

#pragma mark - SINGLETON
+ (AFDatabaseManager *)sharedManager {
    static AFDatabaseManager *sharedDatabase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDatabase = [[AFDatabaseManager alloc] init];
    });
    return sharedDatabase;
}

#pragma mark - Circular
#pragma mark - Circular
#pragma mark - Create Circular
- (Circular *)createCircular:(AFIMCircular *)circular {
    
    Circular *ci = [Circular find:@"circularId == %@", circular.circularId];
    
    if (ci) {
        [ci setAccessCount:[circular.accessCount intValue]];
        [ci setArchiveName:[circular.archiveName absoluteString]];
        [ci setRead:[circular.read boolValue]];
        [ci setRegisterDate:circular.registerDate];
        [ci setTitle:circular.title];
        [ci setUserId:[circular.userId intValue]];
        [ci save];
        return ci;
    } else {
        NSDictionary *dic = @{@"accessCount" : circular.accessCount,
                              @"archiveName" : [circular.archiveName absoluteString],
                              @"circularId" : circular.circularId,
                              @"read" : circular.read,
                              @"registerDate" : circular.registerDate,
                              @"title" : circular.title,
                              @"userId" : circular.userId};
        
        Circular *circ = [Circular create:dic];
        [circ save];
        return circ;
    }
}
#pragma mark - Create & Insert Circular Readers
- (void)insertReaders:(NSArray *)readers inCircular:(Circular *)circular {
    if (circular) {
        NSMutableArray *mutableReaders = [[NSMutableArray alloc] init];
        
        for (AFIMCircularReaders *r in readers) {
            
            if (r.accessDate == nil) {
                [r setAccessDate:[NSDate dateWithTimeIntervalSince1970:0]];
            }
            
            CircularReader *cReader = [CircularReader find:@"circularId == %@ AND userId == %@", r.circularId, r.userId];
            if (cReader) {
                [cReader setAccessDate:r.accessDate];
                [cReader setEnterprise:r.enterprise];
                [cReader setControlId:[r.controlId intValue]];
                [cReader setName:r.name];
                [cReader save];
                [mutableReaders addObject:cReader];
            } else {
                NSDictionary *dic = @{@"accessDate" : r.accessDate,
                                      @"enterprise" : r.enterprise,
                                      @"controlId" : r.controlId,
                                      @"circularId" : r.circularId,
                                      @"userId" : r.userId,
                                      @"name" : r.name};
                
                
                CircularReader *cRead = [CircularReader create:dic];
                [cRead save];
                [mutableReaders addObject:cRead];
            }
        }
        NSArray *reads = [NSArray arrayWithArray:[mutableReaders mutableCopy]];
        NSSet *readersSet = [NSSet setWithArray:reads];
        [circular setReader:readersSet];
        [circular save];
    }
}

- (NSArray *)searchOnCircular:(NSString *)text {
    NSArray *allCircular = [Circular all];
    NSPredicate *predicate;
    if (text.length > 1) {
        predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@", text];
        NSArray *filteredArray = [allCircular filteredArrayUsingPredicate:predicate];
        return filteredArray;
    }
    return allCircular;
}
#pragma mark - Create Official & Official Statements
- (Official *)createOfficial:(AFIMOfficials *)official {
    
    Official *of = [Official find:@"officialId == %@", official.officialId];
    if (of) {
        [of setNeighborhood:official.neighborhood];
        [of setOfficialRole:official.officialRole];
        [of setPostalCode:official.postalCode];
        [of setCity:official.city];
        [of setPhotoName:official.photoName];
        [of setComplement:official.complement];
        [of setColor:official.color];
        
        [of setAdminDate:official.adminDate];
        [of setResignationDate:official.resignationDate];
        [of setBirthDate:official.birthDate];
        [of setBadgeDescription:official.badgeDescription];
        [of setAddress:official.address];
        [of setMomFiliation:official.momFiliation];
        [of setDadFilitation:official.dadFilitation];
        [of setUserId:[official.userId intValue]];
        [of setRegisterId:[official.registerId intValue]];
        [of setImgBase64:official.imgBase64];
        [of setStoreLuc:[official.storeLuc intValue]];
        [of setStoreName:official.storeName];
        [of setBrand:official.brand];
        [of setModel:official.model];
        [of setNaturalness:official.naturalness];
        [of setShopkeeperName:official.shopkeeperName];
        [of setNumber:official.number];
        [of setPlate:official.plate];
        [of setDocumentIdentifier:official.documentIdentifier];
        [of setDocumentInsideCountry:official.documentInsideCountry];
        [of setSexuality:official.sexuality];
        [of setRegisterStatus:[official.registerStatus intValue]];
        [of setPhone:official.phone];
        [of setState:official.state];
        [of setValidateDate:official.validateDate];
        [of setRegisterStatusValue:[official getRegisterStatusValue]];
        [of setSynced:YES];
        [of setOfficialId:[official.officialId intValue]];
        [of save];
        return of;
    } else {
        
        
        NSDictionary *dic = @{@"neighborhood" : official.neighborhood,
                              @"officialRole" : official.officialRole,
                              @"postalCode" : official.postalCode,
                              @"city" : official.city,
                              @"photoName" : official.photoName,
                              @"complement" : official.complement,
                              @"color" : official.color,
                              @"documentIdentifier" : official.documentIdentifier,
                              @"adminDate" : official.adminDate,
                              @"resignationDate" : official.resignationDate,
                              @"birthDate" : ((official.birthDate) ? official.birthDate : @""),
                              @"registerDate" : official.registerDate,
                              @"badgeDescription" : official.badgeDescription,
                              @"address" : official.address,
                              @"momFiliation" : official.momFiliation,
                              @"dadFilitation" : official.dadFilitation,
                              @"userId" : official.userId,
                              @"registerId" : official.registerId,
                              @"imgBase64" : official.imgBase64,
                              @"storeLuc" : official.storeLuc,
                              @"storeName" : official.storeName,
                              @"brand" : official.brand,
                              @"model" : official.model,
                              @"naturalness" : official.naturalness,
                              @"shopkeeperName" : official.shopkeeperName,
                              @"number" : official.number,
                              @"plate" : official.plate,
                              @"documentInsideCountry" : official.documentInsideCountry,
                              @"sexuality" : official.sexuality,
                              @"registerStatus" : official.registerStatus,
                              @"phone" : official.phone,
                              @"state" : official.state,
                              @"validateDate" : official.validateDate,
                              @"registerStatusValue" : [official getRegisterStatusValue],
                              @"officialId" : official.officialId};
        
        Official *offi = [Official create:dic];
        [offi save];
        return offi;
    }
}

- (NSArray *)searchOnOfficial:(NSString *)text {
    NSArray *allOfficials = [Official all];
    NSPredicate *predicate;
    if (text.length > 1) {
        predicate = [NSPredicate predicateWithFormat:@"(storeName contains[cd] %@) OR (brand contains[cd] %@) OR (model contains[cd] %@) OR (shopkeeperName contains[cd] %@)", text, text, text, text, text];
        NSArray *filteredArray = [allOfficials filteredArrayUsingPredicate:predicate];
        return filteredArray;
    }
    return allOfficials;
}

- (NSInteger)getLastOfficialId {
    NSArray *allOfficials = [Official all];
    NSMutableArray *allIds = [[NSMutableArray alloc] init];
    for (Official *f in allOfficials) {
        [allIds addObject:@(f.officialId)];
    }
    NSArray *ordered = [allIds sortedArrayUsingSelector:@selector(compare:)];
    NSNumber *lastId = (NSNumber *)[ordered lastObject];
    return [lastId integerValue];
}

#pragma mark - Create Service Order & Service Order Statements
- (ServiceOrder *)createServiceOrder:(AFIMServiceOrder *)serviceOrder {
    ServiceOrder *so = [ServiceOrder find:@"serviceOrderId == %@", serviceOrder.serviceOrderId];
    NSLog(@"so :%d", so.serviceOrderId);
    if (so) {
        NSSet *emptySet = [[NSSet alloc] initWithArray:@[]];
        [so setUserId:[serviceOrder.userId intValue]];
        [so setStatusId:[serviceOrder.statusId intValue]];
        [so setEnterprise:serviceOrder.enterprise];
        [so setLuc:serviceOrder.luc];
        [so setTypeId:[serviceOrder.typeId intValue]];
        [so setRegisterDate:serviceOrder.registerDate];
        [so setRegisterHour:serviceOrder.registerHour];
        [so setInitialDate:serviceOrder.initialDate];
        [so setInitialHour:serviceOrder.initialHour];
        [so setFinalDate:serviceOrder.finalDate];
        [so setFinalHour:serviceOrder.finalHour];
        [so setInitialDateHour:serviceOrder.initialDateHour];
        [so setFinalDateHour:serviceOrder.finalDateHour];
        [so setShopkeeperName:serviceOrder.shopkeeperName];
        [so setRequesterName:serviceOrder.requesterName];
        [so setPhone:serviceOrder.phone];
        [so setEmail:serviceOrder.email];
        [so setServiceOrderDescription:serviceOrder.serviceOrderDescription];
        [so setDestinationId:[serviceOrder.destinationId intValue]];
        [so setStatus:serviceOrder.status];
        [so setImgStatus:serviceOrder.imgNameStatus];
        [so setSynced:serviceOrder.synced];
        [so setApprovers:emptySet];
        [so setAuthorizedUsers:emptySet];
        [so setFiles:emptySet];
        [so setObservations:emptySet];
        [so setServiceType:serviceOrder.serviceType];
        [so setDestinationUser:nil];
        
        [so save];
        
        return so;
    } else {
        NSDictionary *dic = @{@"serviceOrderId" : serviceOrder.serviceOrderId,
                              @"userId" : serviceOrder.userId,
                              @"enterprise" : serviceOrder.enterprise,
                              @"luc" : serviceOrder.luc,
                              @"typeId" : serviceOrder.typeId,
                              @"registerDate" : serviceOrder.registerDate,
                              @"registerHour" : serviceOrder.registerHour,
                              @"initialDate" : serviceOrder.initialDate,
                              @"initialHour" : serviceOrder.initialHour,
                              @"finalDate" : serviceOrder.finalDate,
                              @"finalHour" : serviceOrder.finalHour,
                              @"initialDateHour" : serviceOrder.initialDateHour,
                              @"finalDateHour" : serviceOrder.finalDateHour,
                              @"shopkeeperName" : serviceOrder.shopkeeperName,
                              @"requesterName" : serviceOrder.requesterName,
                              @"phone" : serviceOrder.phone,
                              @"email" : serviceOrder.email,
                              @"serviceOrderDescription" : serviceOrder.serviceOrderDescription,
                              @"destinationId" : serviceOrder.destinationId,
                              @"status" : serviceOrder.status,
                              @"statusId" : serviceOrder.statusId,
                              @"imgStatus" : serviceOrder.imgNameStatus,
                              @"serviceType" : serviceOrder.serviceType,
                              @"synced" : @(serviceOrder.synced)};
        
        ServiceOrder *serviOrder = [ServiceOrder create:dic];
        [serviOrder save];
        return serviOrder;

    }
}
- (ServiceOrder *)createNewServiceOrder:(AFIMNewServiceOrder *)newServiceOrder withNewDictionaryServiceOrder:(AFIMServiceOrder *)newSO {
    int serviceOrderId = [newSO.serviceOrderId intValue];
    ServiceOrder *s = [ServiceOrder find:@"serviceOrderId == %@", @(serviceOrderId)];
    
    if (s) {
        NSLog(@"Criou um que ja tem?");
    } else {
        NSDictionary *dic = @{@"serviceOrderId" : @(serviceOrderId),
                              @"userId" : newServiceOrder.loggedUser.userId,
                              @"enterprise" : newServiceOrder.loggedUser.company,
                              @"luc" : newServiceOrder.loggedUser.luc,
                              @"typeId" : newServiceOrder.loggedUser.userType,
                              @"registerDate" : [NSDate date],
                              @"registerHour" : [NSDate date],
                              @"initialDate" : newServiceOrder.initialDate,
                              @"initialHour" : newServiceOrder.initialHour,
                              @"finalDate" : newServiceOrder.finalDate,
                              @"finalHour" : newServiceOrder.finalHour,
                              @"initialDateHour" : newServiceOrder.initialDate,
                              @"finalDateHour" : newServiceOrder.finalDate,
                              @"shopkeeperName" : newServiceOrder.loggedUser.username,
                              @"requesterName" : newServiceOrder.requesterName,
                              @"phone" : newServiceOrder.loggedUser.phone,
                              @"email" : newServiceOrder.loggedUser.email,
                              @"serviceOrderDescription" : newServiceOrder.serviceOrderDescription,
                              @"destinationId" : @(1),
                              @"observations" : @"",
                              @"status" : @"Em Aprovação",
                              @"statusId" : @(1),
                              @"synced" : @(NO)};
        
        ServiceOrder *serviOrder = [ServiceOrder create:dic];
        [serviOrder save];
        
        
        for (AFIMServiceOrderAuthorizedUsers *u in newSO.authorizedUsers) {
            ServiceOrderAuthorizedUser *authorizedUser = [NSEntityDescription insertNewObjectForEntityForName:@"ServiceOrderAuthorizedUser" inManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]];
            
            [authorizedUser setName:u.name];
            [authorizedUser setDocumentInsideCountry:u.documentInsideCountry];
            [authorizedUser setEnterprise:u.enterprise];
            [authorizedUser setUserIdAuthorized:[u.userIdAuthorized intValue]];
            [authorizedUser setServiceOrderId:serviceOrderId];
            
            [authorizedUser setServiceOrder:serviOrder];
            [authorizedUser save];
            
            NSMutableArray *authorizedUsers = [[NSMutableArray alloc] initWithArray:[serviOrder.authorizedUsers allObjects]];
            [authorizedUsers addObject:authorizedUser];
            
            NSSet *set = [NSSet setWithArray:[authorizedUsers mutableCopy]];
            [serviOrder setAuthorizedUsers:set];
            [serviOrder save];
            [[CoreDataManager sharedManager] managedObjectContext];
            
        }
        
        for (AFFile *f in newServiceOrder.files) {
            ServiceOrderFile *serviceFile = [NSEntityDescription insertNewObjectForEntityForName:@"ServiceOrderFile" inManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]];
            
            [serviceFile setFileExtension:f.fileExtension];
            [serviceFile setFileUrl:f.fileEncoded];
            [serviceFile setServiceOrderId:serviceOrderId];
            [serviceFile setServiceOrder:serviOrder];
            [serviceFile save];
            
            NSMutableArray *files = [[NSMutableArray alloc] initWithArray:[serviOrder.files allObjects]];
            [files addObject:serviceFile];
            
            NSSet *set = [NSSet setWithArray:[files mutableCopy]];
            [serviOrder setFiles:set];
            [serviOrder save];
            [[CoreDataManager sharedManager] managedObjectContext];
            
        }
        
    }
    
    return nil;
}

- (void)insertApproversInto:(ServiceOrder *)serviceOrder withApprover:(AFIMServiceOrderApprovers *)serviceOrderApprover {
    
    ServiceOrderApprover *soApprover = [NSEntityDescription insertNewObjectForEntityForName:@"ServiceOrderApprover" inManagedObjectContext:[[CoreDataManager sharedManager]managedObjectContext]];
    [soApprover setAction:[serviceOrderApprover.action intValue]];
    [soApprover setLofted:[serviceOrderApprover.lofted intValue]];
    [soApprover setEmail:serviceOrderApprover.email];
    [soApprover setUserApproverId:[serviceOrderApprover.userApproverId intValue]];
    [soApprover setName:serviceOrderApprover.name];
    [soApprover setSubstitute:[serviceOrderApprover.substitute intValue]];
    [soApprover setServiceOrderApproved:serviceOrder];
    [soApprover save];
    
    NSMutableArray *approvers = [[NSMutableArray alloc] init];
    [approvers addObjectsFromArray:[serviceOrder.approvers allObjects]];
    [approvers addObject:soApprover];
    NSSet *set = [NSSet setWithArray:[approvers mutableCopy]];
    [serviceOrder setApprovers:set];
    [serviceOrder save];
    [[CoreDataManager sharedManager] saveContext];
    
}

- (void)insertAuthorizedUsersInto:(ServiceOrder *)serviceOrder withAuthorized:(AFIMServiceOrderAuthorizedUsers *)authorizedUsers {
    ServiceOrderAuthorizedUser *soAuthorized = [NSEntityDescription insertNewObjectForEntityForName:@"ServiceOrderAuthorizedUser" inManagedObjectContext:[[CoreDataManager sharedManager]managedObjectContext]];
    
    [soAuthorized setEnterprise:authorizedUsers.enterprise];
    [soAuthorized setUserIdAuthorized:[authorizedUsers.userIdAuthorized intValue]];
    [soAuthorized setServiceOrderId:[authorizedUsers.serviceOrderId intValue]];
    [soAuthorized setName:authorizedUsers.name];
    [soAuthorized setDocumentInsideCountry:authorizedUsers.documentInsideCountry];
    [soAuthorized setServiceOrder:serviceOrder];
    [soAuthorized save];
    
    NSMutableArray *authorized = [[NSMutableArray alloc] init];
    [authorized addObjectsFromArray:[serviceOrder.authorizedUsers allObjects]];
    [authorized addObject:soAuthorized];
    NSSet *set = [NSSet setWithArray:[authorized mutableCopy]];
    [serviceOrder setAuthorizedUsers:set];
    [serviceOrder save];
    [[CoreDataManager sharedManager] saveContext];

}
- (void)insertDestinationUserInto:(ServiceOrder *)serviceOrder withDestinationUser:(AFIMServiceOrderDestinationUser *)destinationUser {
    
    ServiceOrderDestinationUser *orderDestination = [ServiceOrderDestinationUser create:@{@"email" : destinationUser.email,
                                                                                          @"enterprise" : destinationUser.enterprise,
                                                                                          @"userIdDestination" : destinationUser.userIdDestination,
                                                                                          @"luc" : destinationUser.luc,
                                                                                          @"name" : destinationUser.name,
                                                                                          @"phone" : destinationUser.phone}];
    [orderDestination save];
    [serviceOrder setDestinationUser:orderDestination];
    [serviceOrder save];
    
    [[CoreDataManager sharedManager] saveContext];
}
- (void)insertFileInto:(ServiceOrder *)serviceOrder withFile:(AFIMServiceOrderFile *)file {
    ServiceOrderFile *soFile = [NSEntityDescription insertNewObjectForEntityForName:@"ServiceOrderFile" inManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]];
    
    [soFile setFileUrl:file.fileUrl];
    [soFile setArchiveId:[file.archiveId intValue]];
    [soFile setServiceOrderId:[file.serviceOrderId intValue]];
    [soFile setUserId:[file.userId intValue]];
    [soFile setCode:file.code];
    [soFile setFileExtension:file.fileExtension];
    [soFile setServiceOrder:serviceOrder];
    [soFile save];
    
    NSMutableArray *files = [[NSMutableArray alloc] init];
    [files addObjectsFromArray:[serviceOrder.files allObjects]];
    [files addObject:soFile];
    NSSet *set = [NSSet setWithArray:[files mutableCopy]];
    [serviceOrder setFiles:set];
    [serviceOrder save];
    [[CoreDataManager sharedManager] saveContext];
}
- (NSArray *)searchOnServiceOrder:(NSString *)text {
    NSArray *allServiceOrder = [ServiceOrder all];
    NSPredicate *predicate;
    if (text.length > 1) {
        predicate = [NSPredicate predicateWithFormat:@"(requesterName contains[cd] %@) OR (status contains[cd] %@) OR (serviceOrderDescription contains[cd] %@) OR (enterprise contains[cd] %@) OR (email contains[cd] %@) OR (serviceOrderId == %@)", text, text, text, text, text, text, @([text integerValue])];
        NSArray *filteredArray = [allServiceOrder filteredArrayUsingPredicate:predicate];
        return filteredArray;
    }
    return allServiceOrder;
}
#pragma mark - User Sectors
- (UserSector *)createUserSector:(AFIMUserSector *)sector {
    UserSector *s = [UserSector find:@"sectorId == %@", sector.sectorId];
    
    if (s) {
        NSSet *emptySet = [[NSSet alloc] initWithArray:@[]];
        [s setServiceTypes:emptySet];
        [s setSectorDescription:sector.sectorDescription];
        [s save];
        return s;
    } else {
        NSDictionary *d = @{@"sectorDescription" : sector.sectorDescription,
                            @"sectorId" : sector.sectorId};
        UserSector *uSector = [UserSector create:d];
        [uSector save];
        return uSector;
    }
}
- (void)insertSectorTypeInto:(UserSector *)userSector withServiceType:(AFIMUserTypeService *)typeService {
    UserServiceType *serviceType = [NSEntityDescription insertNewObjectForEntityForName:@"UserServiceType" inManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]];
    
    [serviceType setActive:[typeService.active boolValue]];
    [serviceType setServiceDescription:typeService.serviceDescription];
    [serviceType setOutOfService:[typeService.outOfService intValue]];
    [serviceType setDepartmentId:[typeService.departmentId intValue]];
    [serviceType setTypeId:[typeService.typeId intValue]];
    [serviceType setAttachmentRequired:[typeService.attachmentRequired boolValue]];
    [serviceType setObservationRequired:[typeService.observationRequired boolValue]];
    [serviceType setObservation:typeService.observation];
    [serviceType setSector:userSector];
    [serviceType setSelected:NO];
    
    
    [serviceType save];
    NSMutableArray *mutableServices = [[NSMutableArray alloc] initWithArray:[userSector.serviceTypes allObjects]];
    [mutableServices addObject:serviceType];
    [userSector setServiceTypes:[NSSet setWithArray:[mutableServices mutableCopy]]];
    [userSector save];
    [[CoreDataManager sharedManager] saveContext];
}

#pragma mark - Authorized User
- (ServiceOrderAuthorizedUser *)createAuthorizedUser:(NSString *)name documentInsideCountry:(NSString *)documentInsideCountry enterprise:(NSString *)enterprise {
    
    NSInteger lastId = [self getLastAuthorizedId] + 1;
    ServiceOrderAuthorizedUser *serviceUser = [ServiceOrderAuthorizedUser create:@{@"name" : name,
                                         @"documentInsideCountry" : documentInsideCountry,
                                         @"enterprise" : enterprise,
                                         @"userIdAuthorized" : @(lastId)}];
    [serviceUser save];
    return serviceUser;
}

- (NSArray *)getCorrectAuthorizedUsers {
    NSArray *allAuthorizedUsers = [ServiceOrderAuthorizedUser all];
    NSMutableArray *correctAuthorizedMutable = [[NSMutableArray alloc] init];
    for (ServiceOrderAuthorizedUser *u in allAuthorizedUsers) {
        NSLog(@"u.name = %@", u.name);
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userIdAuthorized == %@", @(u.userIdAuthorized)];
        NSArray *myUsers = [correctAuthorizedMutable mutableCopy];
        NSArray *alreadyExist = [myUsers filteredArrayUsingPredicate:predicate];
        if ([alreadyExist count] > 0) {
            NSLog(@"JA EXISTE");
        } else {
            [correctAuthorizedMutable addObject:u];
            
        }
    }
    NSMutableArray *authorizedMutable = [[NSMutableArray alloc] init];
    for (ServiceOrderAuthorizedUser *u2 in correctAuthorizedMutable) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enterprise == %@ AND documentInsideCountry == %@ AND name == %@", u2.enterprise, u2.documentInsideCountry, u2.name];
        
        NSArray *alreadyExist = [[authorizedMutable mutableCopy] filteredArrayUsingPredicate:predicate];
        
        if ([alreadyExist count] > 0) {
            
        } else {
            [authorizedMutable addObject:u2];
        }
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *correctUsersAlphabetically = [[NSArray arrayWithArray:[authorizedMutable mutableCopy]] sortedArrayUsingDescriptors:@[sort]];
    
    return correctUsersAlphabetically;
}

- (NSInteger)getLastAuthorizedId {
    NSArray *allAuthorizeds = [ServiceOrderAuthorizedUser all];
    NSMutableArray *allIds = [[NSMutableArray alloc] init];
    for (ServiceOrderAuthorizedUser *f in allAuthorizeds) {
        [allIds addObject:@(f.userIdAuthorized)];
    }
    NSArray *ordered = [allIds sortedArrayUsingSelector:@selector(compare:)];
    NSNumber *lastId = (NSNumber *)[ordered lastObject];
    return [lastId integerValue];
}

#pragma mark - User Calendar
- (UserCalendar *)createUserCalendar:(AFIMUserCalendar *)userCalendar {
    if (userCalendar.date) {
        UserCalendar *uCalendar = [UserCalendar find:@"date == %@", userCalendar.date];
        
        if (uCalendar) {
            [uCalendar setUsefulDay:[userCalendar.usefulDay boolValue]];
            [uCalendar setHoliday:[userCalendar.holiday boolValue]];
            
            return uCalendar;
        } else {
            NSDictionary *dic = @{@"date" : userCalendar.date,
                                  @"holiday" : userCalendar.holiday,
                                  @"usefulDay" : userCalendar.usefulDay};
            UserCalendar *uCal = [UserCalendar create:dic];
            [uCal save];
            return uCal;
        }
    }
    return nil;
}
#pragma mark - Service Order Observations
- (void)insertObservationsInto:(ServiceOrder *)serviceOrder withObservation:(AFIMServiceOrderObservations *)orderObservations {
    
    
    ServiceOrderObservations *soObservation = [NSEntityDescription insertNewObjectForEntityForName:@"ServiceOrderObservations" inManagedObjectContext:[[CoreDataManager sharedManager] managedObjectContext]];
    [soObservation setServiceOrderId:[orderObservations.serviceOrderId intValue]];
    [soObservation setObservation:orderObservations.observation];
    [soObservation setUserId:[orderObservations.userId intValue]];
    [soObservation setRegisterDate:orderObservations.registerDate];
    [soObservation setRegisterHour:orderObservations.registerHour];
    [soObservation setObservationId:[orderObservations.observationId intValue]];
    
    [soObservation setUserObservationId:[orderObservations.userObservationId intValue]];
    [soObservation setUserObservationName:orderObservations.userObservationName];
    [soObservation setUserObservationEnterprise:orderObservations.userObservationEnterprise];
    [soObservation setUserObservationEmail:orderObservations.userObservationEmail];
    [soObservation setUserObservationPhone:orderObservations.userObservationPhone];
    if (orderObservations.userObservationDate) {
        [soObservation setUserObservationDate:orderObservations.userObservationDate];
    }
    
    [soObservation save];
    
    
    NSMutableArray *mutableObservations = [[NSMutableArray alloc] initWithArray:[serviceOrder.observations allObjects]];
    [mutableObservations addObject:soObservation];
    [serviceOrder setObservations:[NSSet setWithArray:[mutableObservations mutableCopy]]];
    [serviceOrder save];
    [[CoreDataManager sharedManager] saveContext];
}
#pragma mark - Getters
- (NSArray *)getRecentServiceOrders {
    NSArray *serviceOrders = [ServiceOrder all];
    
    NSSortDescriptor *sortServiceOrderId = [[NSSortDescriptor alloc] initWithKey:@"serviceOrderId" ascending:NO];
    
    NSArray *orderedServiceOrders = [serviceOrders sortedArrayUsingDescriptors:@[sortServiceOrderId]];

    return orderedServiceOrders;
}

@end

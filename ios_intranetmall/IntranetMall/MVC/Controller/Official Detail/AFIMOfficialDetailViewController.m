
//
//  AFIMOfficialDetailViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 15/12/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMOfficialDetailViewController.h"
#import "UITextField+Extras.h"
#import "NSString+Extras.h"

@interface AFIMOfficialDetailViewController ()

@end

@implementation AFIMOfficialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnBarSave = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgSave"] style:UIBarButtonItemStylePlain target:self action:@selector(saveOfficial:)];
    [self.navigationItem setRightBarButtonItem:_btnBarSave];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self organizeUser];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_tblView setDelegate:self];
    [_tblView setDataSource:self];
    
}

- (void)organizeUser {
    if (!_official) {
        [self setTitle:@"Novo funcionário"];
        _basics = [self getInitialBasicsDatas];
        _addresses = [self getInitialAddresses];
        _photos = @[@""];
    } else {
        _basics = [self getExistingUserBasicsDatas];
        _addresses = [self getExistingAddresses];
        _photos = @[_official.imgBase64];
        [self setTitle:_official.shopkeeperName];
    }
    [self didSelectSegment:_segControl];
    [_tblView reloadData];
}

- (BOOL)checkValidationOfForm:(AFForm *)form {
    
    return YES;
}

#pragma mark - Organizing Initial Infos
- (NSArray *)getInitialBasicsDatas {
    NSMutableArray *basics = [[NSMutableArray alloc] init];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@"CPF" values:@"" images:nil isDual:NO formMask:@"###.###.###-##" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(YES) formTypeValidation:@(kAFFormTypeValidationDocumentIdentifier)]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@"Nome" values:@"" images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(YES) formTypeValidation:@(kAFFormTypeValidationGeneralName)]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@[@"Número do RG", @"Data Nascimento"] values:@[@"", @""] images:@[@"", [UIImage imageNamed:@"imgCalendarPicker"]] isDual:YES formMask:@[@"", @"##/##/####"] type:kAFFormTypeDual cellType:@"CellDual" needsAValidation:@[@(NO), @(YES)] formTypeValidation:@[@(99), @(kAFFormTypeValidationDates)]]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@[@"Naturalidade", @"Sexo"] values:@[@"", @"Selecione"] images:nil isDual:YES formMask:@[@"", @""] type:kAFFormTypeUniqueCheckbox cellType:@"CellUniqueCheckbox" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@"Nome da mãe" values:@"" images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(YES) formTypeValidation:@(kAFFormTypeValidationGeneralName)]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@"Nome do pai" values:@"" images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(YES) formTypeValidation:@(kAFFormTypeValidationGeneralName)]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@[@"Cargo", @"Telefone"] values:@[@"", @""] images:@[@"", @""] isDual:YES formMask:@[@"", @"(##)#####-####"] type:kAFFormTypeDual cellType:@"CellDual" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@[@"Data Admissão", @"Data Demissão"] values:@[@"", @""] images:@[[UIImage imageNamed:@"imgCalendarPicker"], [UIImage imageNamed:@"imgCalendarPicker"]] isDual:YES formMask:@[@"##/##/####", @"##/##/####"] type:kAFFormTypeDual cellType:@"CellDual" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    
    
    NSArray *datas = [NSArray arrayWithArray:[basics mutableCopy]];
    return datas;
}

- (NSArray *)getInitialAddresses {
    NSMutableArray *addresses = [[NSMutableArray alloc] init];
    [addresses addObject:[[AFForm alloc] initWithTitle:@"CEP" values:@"" images:[UIImage imageNamed:@"imgSearchBlack"] isDual:NO formMask:@"#####-###" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(YES) formTypeValidation:@(kAFFormTypeValidationZipCode)]];
    [addresses addObject:[[AFForm alloc] initWithTitle:@"Endereço" values:@"" images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(NO) formTypeValidation:@(99)]];
    [addresses addObject:[[AFForm alloc] initWithTitle:@[@"Número", @"Complemento"] values:@[@"", @""] images:@[@"", @""] isDual:YES formMask:@[@"", @""] type:kAFFormTypeDual cellType:@"CellDual" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    [addresses addObject:[[AFForm alloc] initWithTitle:@"Bairro" values:@"" images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(NO) formTypeValidation:@(99)]];
    
    [addresses addObject:[[AFForm alloc] initWithTitle:@[@"Município", @"UF"] values:@[@"", @""] images:nil isDual:YES formMask:@[@"", @""] type:kAFFormTypeUniqueCheckbox cellType:@"CellUniqueCheckbox" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    
    NSArray *add = [NSArray arrayWithArray:[addresses mutableCopy]];
    
    return add;
    
}

#pragma mark - Organizing Existing User Infos

- (NSArray *)getExistingUserBasicsDatas {
    
    
    NSMutableArray *basics = [[NSMutableArray alloc] init];
    
    NSLog(@"%@", [NSString stringGetDayDate:_official.birthDate]);
    
    [basics addObject:[[AFForm alloc] initWithTitle:@"CPF" values:_official.documentIdentifier images:nil isDual:NO formMask:@"###.###.###-##" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(YES) formTypeValidation:@(kAFFormTypeValidationDocumentIdentifier)]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@"Nome" values:_official.shopkeeperName images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(YES) formTypeValidation:@(kAFFormTypeValidationGeneralName)]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@[@"Número do RG", @"Data Nascimento"] values:@[[NSString stringWithFormat:@"%@", _official.documentInsideCountry], [NSString stringGetDayDate:_official.birthDate]] images:@[@"", [UIImage imageNamed:@"imgCalendarPicker"]] isDual:YES formMask:@[@"", @"##/##/####"] type:kAFFormTypeDual cellType:@"CellDual" needsAValidation:@[@(NO), @(YES)] formTypeValidation:@[@(99), @(kAFFormTypeValidationDates)]]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@[@"Naturalidade", @"Sexo"] values:@[[NSString stringWithFormat:@"%@", _official.naturalness], [NSString stringWithFormat:@"%@", _official.sexuality]] images:nil isDual:YES formMask:@[@"", @""] type:kAFFormTypeUniqueCheckbox cellType:@"CellUniqueCheckbox" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@"Nome da mãe" values:[NSString stringWithFormat:@"%@", _official.momFiliation] images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(NO) formTypeValidation:@(kAFFormTypeValidationGeneralName)]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@"Nome do pai" values:[NSString stringWithFormat:@"%@", _official.dadFilitation] images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(NO) formTypeValidation:@(kAFFormTypeValidationGeneralName)]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@[@"Cargo", @"Telefone"] values:@[[NSString stringWithFormat:@"%@", _official.officialRole], [NSString stringWithFormat:@"%@", _official.phone]] images:@[@"", @""] isDual:YES formMask:@[@"", @"(##)#####-####"] type:kAFFormTypeDual cellType:@"CellDual" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    
    [basics addObject:[[AFForm alloc] initWithTitle:@[@"Data Admissão", @"Data Demissão"] values:@[[NSString stringGetDayDate:_official.adminDate], [NSString stringGetDayDate:_official.resignationDate]] images:@[[UIImage imageNamed:@"imgCalendarPicker"], [UIImage imageNamed:@"imgCalendarPicker"]] isDual:YES formMask:@[@"##/##/####", @"##/##/####"] type:kAFFormTypeDual cellType:@"CellDual" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    
    
    NSArray *datas = [NSArray arrayWithArray:[basics mutableCopy]];
    return datas;
    
}

- (NSArray *)getExistingAddresses {
    NSMutableArray *addresses = [[NSMutableArray alloc] init];
    
    [addresses addObject:[[AFForm alloc] initWithTitle:@"CEP" values:[NSString stringWithFormat:@"%@", _official.postalCode] images:[UIImage imageNamed:@"imgSearchBlack"] isDual:NO formMask:@"#####-###" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(YES) formTypeValidation:@(kAFFormTypeValidationZipCode)]];
    
    [addresses addObject:[[AFForm alloc] initWithTitle:@"Endereço" values:[NSString stringWithFormat:@"%@", _official.address] images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(NO) formTypeValidation:@(99)]];
    
    [addresses addObject:[[AFForm alloc] initWithTitle:@[@"Número", @"Complemento"] values:@[[NSString stringWithFormat:@"%@", _official.number], [NSString stringWithFormat:@"%@", _official.complement]] images:@[@"", @""] isDual:YES formMask:@[@"", @""] type:kAFFormTypeDual cellType:@"CellDual" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    
    [addresses addObject:[[AFForm alloc] initWithTitle:@"Bairro" values:[NSString stringWithFormat:@"%@", _official.neighborhood] images:nil isDual:NO formMask:@"" type:kAFFormTypeUnique cellType:@"CellUnique" needsAValidation:@(NO) formTypeValidation:@(99)]];
    
    [addresses addObject:[[AFForm alloc] initWithTitle:@[@"Município", @"UF"] values:@[[NSString stringWithFormat:@"%@", _official.city], [NSString stringWithFormat:@"%@", _official.state]] images:nil isDual:YES formMask:@[@"", @""] type:kAFFormTypeUniqueCheckbox cellType:@"CellUniqueCheckbox" needsAValidation:@[@(NO), @(NO)] formTypeValidation:@[@(99), @(99)]]];
    
    
    NSArray *add = [NSArray arrayWithArray:[addresses mutableCopy]];
    
    return add;
    
}

- (BOOL)fieldsAreValidated {
    NSMutableArray *allFields = [[NSMutableArray alloc] init];
    [allFields addObjectsFromArray:_basics];
    [allFields addObjectsFromArray:_addresses];
    for (AFForm *f in allFields) {
        if (![self validatedField:f]) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)validatedField:(AFForm *)f {
    if (f.dual) {
        NSNumber *needsValidationFirstItem = (NSNumber *)f.needsAValidation[0];
        NSNumber *needsValidationSecondItem = (NSNumber *)f.needsAValidation[1];
        
        if ([needsValidationFirstItem boolValue]) {
            NSNumber *validation = (NSNumber *)f.formTypeValidation[0];
            NSString *value = [NSString stringWithFormat:@"%@", f.values[0]];
            NSString *stringReturn = [self validateFieldWithType:[validation integerValue] andValue:value];
            if (stringReturn) {
                [self showDefaultAlertView:@"Atenção" andMessage:stringReturn completionAction:^(NSString *action) {
                    
                }];
                return NO;
            }
        }
        
        if ([needsValidationSecondItem boolValue]) {
            NSNumber *validation = (NSNumber *)f.formTypeValidation[1];
            NSString *value = [NSString stringWithFormat:@"%@", f.values[1]];
            NSString *stringReturn = [self validateFieldWithType:[validation integerValue] andValue:value];
            if (stringReturn) {
                [self showDefaultAlertView:@"Atenção" andMessage:stringReturn completionAction:^(NSString *action) {
                    
                }];
                return NO;
            }
        }
        return YES;
    } else {
        NSNumber *needsValidation = (NSNumber *)f.needsAValidation;
        if ([needsValidation boolValue]) {
            NSNumber *validation = (NSNumber *)f.formTypeValidation;
            NSString *value = [NSString stringWithFormat:@"%@", f.values];
            NSString *stringReturn = [self validateFieldWithType:[validation integerValue] andValue:value];
            if (stringReturn) {
                [self showDefaultAlertView:@"Atenção" andMessage:stringReturn completionAction:^(NSString *action) {
                    
                }];
                return NO;
            }
        }
        return YES;
    }
    return NO;
}
#pragma mark - Organize Parameters
- (NSMutableDictionary *)getParametersToSend {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *infosDic = [[NSMutableDictionary alloc] init];
    for (AFForm *f in _basics) {
        if (!f.dual) {
            NSString *ke = [NSString stringWithFormat:@"%@", f.titles];
            NSString *val = [NSString stringWithFormat:@"%@", f.values];
            
            [infosDic setValue:val forKey:[NSString getValueForItemForm:ke]];
        } else {
            NSString *ke1 = [NSString stringWithFormat:@"%@", f.titles[0]];
            NSString *ke2 = [NSString stringWithFormat:@"%@", f.titles[1]];
            
            NSString *val1 = [NSString stringWithFormat:@"%@", f.values[0]];
            NSString *val2 = [NSString stringWithFormat:@"%@", f.values[1]];
            
            [infosDic setValue:val1 forKey:[NSString getValueForItemForm:ke1]];
            [infosDic setValue:val2 forKey:[NSString getValueForItemForm:ke2]];
        }
    }
    
    for (AFForm *f in _addresses) {
        if (!f.dual) {
            NSString *ke = [NSString stringWithFormat:@"%@", f.titles];
            NSString *val = [NSString stringWithFormat:@"%@", f.values];
            
            [infosDic setValue:val forKey:[NSString getValueForItemForm:ke]];
        } else {
            NSString *ke1 = [NSString stringWithFormat:@"%@", f.titles[0]];
            NSString *ke2 = [NSString stringWithFormat:@"%@", f.titles[1]];
            
            
            if ([f.values[0] isKindOfClass:[NSDate class]]) {
                NSDate *date = (NSDate *)f.values[0];
                NSDate *val1 = date;
                [infosDic setValue:val1 forKey:[NSString getValueForItemForm:ke1]];
            } else {
                NSString *val1 = [NSString stringWithFormat:@"%@", f.values[0]];
                [infosDic setValue:val1 forKey:[NSString getValueForItemForm:ke1]];
            }
            
            
            if ([f.values[1] isKindOfClass:[NSDate class]]) {
                NSDate *date = (NSDate *)f.values[1];
                NSDate *val2 = date;
                [infosDic setValue:val2 forKey:[NSString getValueForItemForm:ke2]];
            } else {
                NSString *val2 = [NSString stringWithFormat:@"%@", f.values[1]];
                [infosDic setValue:val2 forKey:[NSString getValueForItemForm:ke2]];
            }
        }
    }
    
    for (NSString *s in _photos) {
        [infosDic setValue:s forKey:@"imgBase64"];
    }
    
    if (_official) {
        [infosDic setValue:@(_official.officialId) forKey:@"officialId"];
        [infosDic setValue:@(_official.registerStatus) forKey:@"registerStatus"];
    } else {
        NSInteger lastId = [[AFDatabaseManager sharedManager] getLastOfficialId] + 1;
        [infosDic setValue:@(lastId) forKey:@"officialId"];
    }
    return infosDic;
}

#pragma mark - Call Official API
- (void)callSaveOfficialApi:(NSDictionary *)dic user:(AFIMUser *)user {
    [AFIMOfficials saveOfficial:dic user:user andCompletion:^(NSInteger officialId) {
        [self updateOrCreateOfficial:dic officialId:officialId];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showDefaultAlertView:@"Atenção" andMessage:error.localizedDescription completionAction:^(NSString *action) {
            
        }];
    }];
}

#pragma mark - Update CoreData Official 
- (void)updateOrCreateOfficial:(NSDictionary *)dic officialId:(NSInteger)officialId {
    
    if (officialId > 0) {
        Official *searchOfficial = [Official find:@"officialId == %@", @(officialId)];
        NSString *alertText = @"";
        
        int offId = (int)officialId;
        
        NSDate *birthDate = (NSDate *)[NSDate dateFromStringShortDayMode:[NSString stringWithFormat:@"%@", dic[@"birthDate"]]];
        NSDate *resignationDate = (NSDate *)[NSDate dateFromStringShortDayMode:[NSString stringWithFormat:@"%@", dic[@"resignationDate"]]];
        NSDate *adminDate = (NSDate *)[NSDate dateFromStringShortDayMode:[NSString stringWithFormat:@"%@", dic[@"adminDate"]]];
        
        
        if (!searchOfficial) {
            Official *f = [Official create:dic];
            [f setOfficialId:offId];
            [f setRegisterDate:[NSDate date]];
            [f setPhotoName:@"photoByAppIos"];
            [f setRegisterId:1];
            [f setRegisterStatusValue:@"Novo Cadastro"];
            
            if (adminDate) {
                [f setAdminDate:adminDate];
            }
            if (resignationDate) {
                [f setResignationDate:resignationDate];
            }
            if (birthDate) {
                [f setBirthDate:birthDate];
            }
            
            
            [f save];
            alertText = @"Usuário salvo com sucesso!";
            
        } else {
            
            
            
            [searchOfficial setAddress:dic[@"address"]];
            [searchOfficial setBadgeDescription:dic[@"badgeDescription"]];
            [searchOfficial setRegisterId:1];
            [searchOfficial setRegisterDate:[NSDate date]];
            
            if (adminDate) {
                [searchOfficial setAdminDate:adminDate];
            }
            if (resignationDate) {
                [searchOfficial setResignationDate:resignationDate];
            }
            if (birthDate) {
                [searchOfficial setBirthDate:birthDate];
            }
            
            
            [searchOfficial setBrand:dic[@"brand"]];
            [searchOfficial setShopkeeperName:dic[@"shopkeeperName"]];
            [searchOfficial setCity:dic[@"city"]];
            [searchOfficial setColor:dic[@"color"]];
            [searchOfficial setComplement:dic[@"complement"]];
            [searchOfficial setDadFilitation:dic[@"dadFilitation"]];
            [searchOfficial setDocumentIdentifier:dic[@"documentIdentifier"]];
            [searchOfficial setDocumentInsideCountry:dic[@"documentInsideCountry"]];
            [searchOfficial setImgBase64:dic[@"imgBase64"]];
            [searchOfficial setModel:dic[@"model"]];
            [searchOfficial setMomFiliation:dic[@"momFiliation"]];
            [searchOfficial setNaturalness:dic[@"naturalness"]];
            [searchOfficial setNeighborhood:dic[@"neighborhood"]];
            [searchOfficial setNumber:dic[@"number"]];
            [searchOfficial setPhone:dic[@"phone"]];
            [searchOfficial setPhotoName:dic[@"photoName"]];
            [searchOfficial setPostalCode:dic[@"postalCode"]];
            [searchOfficial setRegisterId:[dic[@"registerId"] intValue]];
            [searchOfficial setRegisterStatus:[dic[@"registerStatus"] intValue]];
            [searchOfficial setRegisterStatusValue:dic[@"registerStatusValue"]];
            [searchOfficial setSexuality:dic[@"sexuality"]];
            [searchOfficial setState:dic[@"state"]];
            [searchOfficial setStoreLuc:[dic[@"storeLuc"] intValue]];
            [searchOfficial setStoreName:dic[@"storeName"]];
            [searchOfficial setRegisterStatusValue:@"Novo Cadastro"];
            [searchOfficial setOfficialId:offId];
            [searchOfficial setUserId:offId];
            [searchOfficial setSynced:searchOfficial.synced];
            [searchOfficial save];
            
            alertText = @"Usuário editado com sucesso!";
        }
        
        [self showDefaultAlertView:@"Atenção" andMessage:alertText completionAction:^(NSString *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

#pragma mark - Validate Fields
- (NSString *)validateFieldWithType:(AFFormTypeValidation)type andValue:(NSString *)v {
    
    switch (type) {
        case kAFFormTypeValidationDocumentIdentifier:
            if ([[v prepareToCheck] cpfIsValid]) {
                return nil;
            } else {
                return @"Parece que seu CPF não é válido!";
            }
            break;
        case kAFFormTypeValidationGeneralName:
            if ([v nameIsValid]) {
                return nil;
            } else {
                return @"Parece que seu nome não está correto!";
            }
            break;
        case kAFFormTypeValidationDates:
            if ([v dateIsValid]) {
                return nil;
            } else {
                return @"Parece que a data de nascimento não é válida!";
            }
            break;
        case kAFFormTypeValidationZipCode:
            if ([v zipCodeIsValid]) {
                return nil;
            } else {
                return @"Parece que seu CEP não é válido!";
            }
            break;
        
        default:
            break;
    }
    return NO;
}

#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_infos count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_infos[indexPath.row] isKindOfClass:[AFForm class]]) {
        return 56.f;
    } else {
        return 280.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([_infos[indexPath.row] isKindOfClass:[AFForm class]]) {
        AFForm *form = _infos[indexPath.row];
        
        
        if ([form.cellType isEqualToString:@"CellUnique"]) {
            static NSString *CellIdentifier = @"CellUnique";
            
            AFIMOfficialEditCellTableViewCell *cell = (AFIMOfficialEditCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.txtFieldUnique setMask:form.mask];
            
            
            
            [cell.lblTitleUnique setText:form.titles];
            
            
            if (form.images) {
                [cell.imgViewUnique setImage:form.images];
                [cell.imgViewUniqueConstraint setConstant:28.f];
                NSString *title = [NSString stringWithFormat:@"%@", form.titles];
                if ([title isEqualToString:@"CEP"]) {
                    [cell.imgViewUnique setTag:indexPath.row];
                    [cell.imgViewUnique setUserInteractionEnabled:YES];
                    [cell.imgViewUnique addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchZipCode:)]];
                }
            } else {
                [cell.imgViewUnique setImage:nil];
                [cell.imgViewUniqueConstraint setConstant:0.f];
            }
            NSString *text = [form.values formatToDocumentIdentifier];
            [cell.txtFieldUnique setText:text];
            [cell.txtFieldUnique setTag:indexPath.row];
            [cell.txtFieldUnique setDelegate:self];
            return cell;
        } else if ([form.cellType isEqualToString:@"CellDual"]) {
            static NSString *CellIdentifier = @"CellDual";
            
            AFIMOfficialEditCellTableViewCell *cell = (AFIMOfficialEditCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.txtFieldFirst setDelegate:self];
            [cell.txtFieldSecond setDelegate:self];
            
            [cell.txtFieldFirst setTag:indexPath.row];
            [cell.txtFieldSecond setTag:indexPath.row];
            
            [cell.txtFieldFirst setMask:form.mask[0]];
            [cell.txtFieldSecond setMask:form.mask[1]];
            
            [cell.txtFieldFirst setText:form.values[0]];
            [cell.txtFieldSecond setText:[form.values[1] formatToPhone]];
            
            [cell.lblFirstTitle setText:form.titles[0]];
            [cell.lblSecondTitle setText:form.titles[1]];
            
            
            if (form.images) {
                if (form.images[0]) {
                    if ([form.images[0] isKindOfClass:[UIImage class]]) {
                        UIImage *img = (UIImage *)form.images[0];
                        [cell.imgViewFirst setImage:img];
                        [cell.imgViewFirstConstraint setConstant:28.f];
                        [cell.imgViewFirst setUserInteractionEnabled:YES];
                        [cell.imgViewFirst setTag:indexPath.row];
                        [cell.imgViewFirst addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDates:)]];
                        
                        
                        UIView *viewFirtsBack = [[UIView alloc] init];
                        [viewFirtsBack setFrame:CGRectMake(0.f, 0.f, cell.txtFieldFirst.frame.size.width, cell.txtFieldFirst.frame.size.height)];
                        
                        [viewFirtsBack setTag:0];
                        [viewFirtsBack setUserInteractionEnabled:YES];
                        
                        [cell.txtFieldFirst addSubview:viewFirtsBack];
                        
                        UIView *viewFirts = [[UIView alloc] init];
                        [viewFirts setFrame:CGRectMake(0.f, 0.f, cell.txtFieldFirst.frame.size.width, cell.txtFieldFirst.frame.size.height)];
                        
                        [viewFirts setTag:indexPath.row];
                        [viewFirts setUserInteractionEnabled:YES];
                        [viewFirts addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDates:)]];
                        
                        
                        [viewFirtsBack addSubview:viewFirts];
                        
                        
                    } else {
                        [cell.imgViewFirst setImage:nil];
                        [cell.imgViewFirstConstraint setConstant:0.f];
                        [cell.imgViewFirst layoutIfNeeded];
                    }
                }
                if (form.images[1]) {
                    if ([form.images[1] isKindOfClass:[UIImage class]]) {
                        UIImage *img = (UIImage *)form.images[1];
                        [cell.imgViewSecond setImage:img];
                        [cell.imgViewSecondConstraint setConstant:28.f];
                        [cell.imgViewSecond setUserInteractionEnabled:YES];
                        [cell.imgViewSecond setTag:indexPath.row];
                        [cell.imgViewSecond addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDates:)]];
                        
                        
                        UIView *viewSecondBack = [[UIView alloc] init];
                        [viewSecondBack setFrame:CGRectMake(0.f, 0.f, cell.txtFieldSecond.frame.size.width, cell.txtFieldSecond.frame.size.height)];
                        
                        [viewSecondBack setTag:1];
                        [viewSecondBack setUserInteractionEnabled:YES];
                        
                        [cell.txtFieldSecond addSubview:viewSecondBack];
                        

                        
                        
                        UIView *viewSecond = [[UIView alloc] init];
                        [viewSecond setFrame:CGRectMake(0.f, 0.f, cell.txtFieldSecond.frame.size.width, cell.txtFieldSecond.frame.size.height)];
                        
                        [viewSecond setTag:indexPath.row];
                        [viewSecond setUserInteractionEnabled:YES];
                        [viewSecond addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDates:)]];
                        
                        
                        [viewSecondBack addSubview:viewSecond];
                        
                    } else {
                        
                        [cell.imgViewSecond setImage:nil];
                        [cell.imgViewSecondConstraint setConstant:0.f];
                        [cell.imgViewSecond layoutIfNeeded];
                        if ([[cell.txtFieldSecond subviews] count] > 0) {
                            for (UIView *v in [cell.txtFieldSecond subviews]) {
                                [v removeFromSuperview];
                            }
                        }
                        
                        
                    }
                }
            }
            
            return cell;
        } else {
            static NSString *CellIdentifier = @"CellUniqueCheckbox";

            AFIMOfficialEditCellTableViewCell *cell = (AFIMOfficialEditCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [cell.lblFirstTitleUniqueCheckbox setText:form.titles[0]];
            [cell.lblSecondTitleUniqueCheckbox setText:form.titles[1]];
            if (form.images) {
                //            if (form.images[0]) {
                //            cell.imgViewFirstUniqueCheckbox setImage:(UIImage * _Nullable)
            }
            [cell.txtFieldFirstUniqueCheckbox setDelegate:self];
            [cell.txtFieldFirstUniqueCheckbox setTag:indexPath.row];
            [cell.txtFieldFirstUniqueCheckbox setText:form.values[0]];
            [cell.txtFieldFirstUniqueCheckbox setTag:indexPath.row];
            //        [cell.txtFieldFirst setMask:form.mask[0]];
            //        [cell.txtFieldSecond setMask:form.mask[1]];
            
            [cell.viewUniqueCheckbox setUserInteractionEnabled:YES];
            [cell.viewUniqueCheckbox setTag:indexPath.row];
            [cell.viewUniqueCheckbox addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showItens:)]];
            [cell.lblValueUniqueCheckbox setText:form.values[1]];
            
            return cell;
        }
    } else {
        static NSString *CellIdentifier = @"CellPhoto";
        
        AFIMOfficialEditCellTableViewCell *cell = (AFIMOfficialEditCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        NSString *photo = _infos[indexPath.row];
        
        if (photo.length > 0) {
            [cell.imgPhoto setContentMode:UIViewContentModeScaleAspectFill];
            [cell.imgPhoto setImage:[UIImage imageWithData:[NSData getDataFromBase64:photo]]];
        } else {
            [cell.imgPhoto setContentMode:UIViewContentModeScaleAspectFit];
            [cell.imgPhoto setImage:[UIImage imageNamed:@"imgGenericPhoto"]];
        }
        [cell.imgPhoto setUserInteractionEnabled:YES];
        [cell.imgPhoto addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prepareToShowCamera:)]];
        [cell.btnPhoto addTarget:self action:@selector(showCamera:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    Circular *circular = _circularList[indexPath.row];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    //    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
    //        [cell setSeparatorInset:UIEdgeInsetsZero];
    //    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UIButton, UISegmentControl Actions
#pragma mark - UIButton, UISegmentControl Actions
- (void)changeSegmentValue:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _infos = _basics;
    } else if (sender.selectedSegmentIndex == 1) {
        _infos = _addresses;
    } else {
        _infos = _photos;
    }
    [_tblView reloadData];
}


- (IBAction)didSelectSegment:(UISegmentedControl *)sender {
    [self.view endEditing:YES];
    [self changeSegmentValue:sender];
}

- (void)saveOfficial:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    
    if ([self fieldsAreValidated]) {
    
        
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[self getParametersToSend]];
        
        [self getUserWithCompletion:^(AFIMUser *user) {
            [self callSaveOfficialApi:dic user:user];
        }];
    }
}

- (void)showItens:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    if (_segControl.selectedSegmentIndex == 0) {
        [self createActionSheet:@"Sexo" rawContents:@[@"Masculino", @"Feminino"] contents:@[@"Masculino", @"Feminino"] selectedIndex:0 index:AFActionSheetFormTypeSex withSender:sender];
    } else if (_segControl.selectedSegmentIndex == 1) {
        NSArray *states = @[@"AC",
                            @"AL",
                            @"AP",
                            @"AM",
                            @"BA",
                            @"CE",
                            @"DF",
                            @"ES",
                            @"GO",
                            @"MA",
                            @"MT",
                            @"MS",
                            @"MG",
                            @"PA",
                            @"PB",
                            @"PR",
                            @"PE",
                            @"PI",
                            @"RJ",
                            @"RN",
                            @"RS",
                            @"RO",
                            @"RR",
                            @"SC",
                            @"SP",
                            @"SE",
                            @"TO"];
        
        [self createActionSheet:@"UF" rawContents:states contents:states selectedIndex:0 index:AFActionSheetFormTypeSex withSender:sender];
    }
}
- (void)showDates:(UITapGestureRecognizer *)sender {
    
    AFForm *form = _infos[sender.view.tag];
    
    NSDate *selectedDate = [NSDate date];
    
    AFActionSheetFormType index = AFActionSheetFormTypeBirthDate;
    if (form.dual) {
        
        if (!_selectedBirthDate) {
            NSDate *date = [NSDate dateFromStringShortDayMode:form.values[sender.view.superview.tag]];
            _selectedBirthDate = date;
        }
        
         selectedDate = _selectedBirthDate;
        
        if ([form.titles[sender.view.superview.tag] isEqualToString:@"Data Admissão"]) {
            index = AFActionSheetFormTypeAdmissionDate;
            if (!_selectedAdmissionalDate) {
                NSDate *date = [NSDate dateFromStringShortDayMode:form.values[sender.view.superview.tag]];
                _selectedAdmissionalDate = date;
            }
            selectedDate = _selectedAdmissionalDate;
        } else if ([form.titles[sender.view.superview.tag] isEqualToString:@"Data Demissão"]) {
            index = AFActionSheetFormTypeDemissionDate;
            if (!_selecteResignedDate) {
                NSDate *date = [NSDate dateFromStringShortDayMode:form.values[sender.view.superview.tag]];
                _selecteResignedDate = date;
            }
            selectedDate = _selecteResignedDate;
        }
    }
    if (!selectedDate) {
        selectedDate = [NSDate date];
    }
    
    [self createActionSheetDatePicker:@"Selecione a data" selectedDate:selectedDate index:index withSender:sender];
}
- (void)searchZipCode:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    AFForm *formAddress = _addresses[0];
    NSString *formPostal = [NSString stringWithFormat:@"%@", formAddress.values];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFPostalCode searchPostalCodeWithPostal:formPostal andCompletion:^(AFPostalCode *postalCodeAddress) {
        
        
        AFForm *formAddress = _addresses[1];
        [formAddress setValues:postalCodeAddress.address];
        
        AFForm *formNeighborhood = _addresses[3];
        [formNeighborhood setValues:postalCodeAddress.neighborhood];
        
        AFForm *formStateCity = _addresses[4];
        [formStateCity setValues:@[postalCodeAddress.city, postalCodeAddress.state]];
        
        
        _infos = _addresses;
        
        [_tblView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
//    http://apps.widenet.com.br/busca-cep/api/cep/06233-030.json
    
}
- (void)prepareToShowCamera:(UITapGestureRecognizer *)sender {
    [self showCamera:nil];
}
- (void)showCamera:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Escolha o que quer compartilhar:" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca", nil];
    [actionSheet showInView:self.view];
}
#pragma mark - Create Action Sheets
- (void)createActionSheet:(NSString *)title rawContents:(NSArray *)rawContents contents:(NSArray *)contents selectedIndex:(NSInteger)selectedIndex index:(AFActionSheetFormType)index withSender:(UITapGestureRecognizer *)sender {
    
    _actionSheetStringPicker = [[ActionSheetStringPicker alloc] initWithTitle:title rows:contents initialSelection:selectedIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        AFForm *form = _infos[sender.view.tag];
        
        NSString *value = [NSString stringWithFormat:@"%@", selectedValue];
        
        if (form.dual) {
            NSArray *initValues = (NSArray *)form.values;
            NSMutableArray *mutableValues = [[NSMutableArray alloc] initWithArray:[initValues mutableCopy]];
            [mutableValues replaceObjectAtIndex:sender.view.superview.tag withObject:value];
            
            NSArray *values = [NSArray arrayWithArray:[mutableValues mutableCopy]];
            
            [form setValues:values];
        }
        
        if (index == AFActionSheetFormTypeSex) {
            
        }
        
        [_tblView reloadData];
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:_tblView];
    [_actionSheetStringPicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"Selecionar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetStringPicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetStringPicker showActionSheetPicker];
}

- (void)createActionSheetDatePicker:(NSString *)title selectedDate:(NSDate *)selectedDate index:(AFActionSheetFormType)index withSender:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:UIDatePickerModeDate selectedDate:selectedDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        NSDate *d = (NSDate *)selectedDate;
        
        if (index == AFActionSheetFormTypeBirthDate) {
            _selectedBirthDate = d;
        } else if (index == AFActionSheetFormTypeAdmissionDate) {
            _selectedAdmissionalDate = d;
        } else if (index == AFActionSheetFormTypeDemissionDate) {
            _selecteResignedDate = d;
        }
        
        AFForm *form = _infos[sender.view.tag];
        
        
        
        NSString *value = [NSString stringWithFormat:@"%@", [NSString stringGetDayDate:d]];
        
        if (form.dual) {
            NSArray *initValues = (NSArray *)form.values;
            NSMutableArray *mutableValues = [[NSMutableArray alloc] initWithArray:[initValues mutableCopy]];
            [mutableValues replaceObjectAtIndex:sender.view.superview.tag withObject:value];
            
            NSArray *values = [NSArray arrayWithArray:[mutableValues mutableCopy]];
            
            [form setValues:values];
        }
        
        [_tblView reloadData];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:_tblView];
        
    
    [_actionSheetDatePicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"Selecionar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetDatePicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetDatePicker setMaximumDate:[NSDate date]];
    [_actionSheetDatePicker showActionSheetPicker];
    
}

#pragma mark - Camera Controls
- (void)openCameraControls:(UIImagePickerControllerSourceType)type {
    if (type == UIImagePickerControllerSourceTypeCamera) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            [self showDefaultAlertView:@"Atenção" andMessage:@"O aparelho que está utilizando não tem uma camera" completionAction:^(NSString *action) {
                
            }];
            return;
        }
    }
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
    }
    [_imagePicker setSourceType:type];
    if (type == UIImagePickerControllerSourceTypeCamera) {
        [_imagePicker setShowsCameraControls:YES];
        [_imagePicker setNavigationBarHidden:YES];
        [_imagePicker setToolbarHidden:YES];
        [_imagePicker setModalPresentationStyle:UIModalPresentationFullScreen];
        [_imagePicker.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    }
    [_imagePicker setDelegate:self];
    [_imagePicker setAllowsEditing:NO];
    
    [self presentViewController:_imagePicker animated:YES completion:NULL];
}
#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
//    NSLog(@"textField :%ld", (long)viewSuperview.tag);
//    NSLog(@"textField.sec :%ld", (long)textField.section);
//    NSLog(@"textField :%@", textField);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    AFForm *form = _infos[textField.tag];
    
    if (form.dual) {
        UIView *viewSuperview = textField.superview;
        NSArray *initValues = (NSArray *)form.values;
        NSMutableArray *mutableValues = [[NSMutableArray alloc] initWithArray:[initValues mutableCopy]];
        [mutableValues replaceObjectAtIndex:viewSuperview.tag withObject:textField.text];
        
        NSArray *values = [NSArray arrayWithArray:[mutableValues mutableCopy]];
        
        [form setValues:values];
        NSString *title = [NSString stringWithFormat:@"%@", form.titles[viewSuperview.tag]];
        if ([title isEqualToString:@"Telefone"]) {
            [_tblView reloadData];
        }
        
    } else {
        [form setValues:textField.text];
    }
    
//    [_tblView reloadData];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    AFForm *form = _infos[textField.tag];
    
    if (!form.dual) {
        NSString *maskText = [NSString stringWithFormat:@"%@", form.mask];
        if (maskText.length > 0) {
            VMaskTextField *vmaskTextField = (VMaskTextField *)textField;
            return  [vmaskTextField shouldChangeCharactersInRange:range replacementString:string];
        } else {
            return YES;
        }
    } else {
        UIView *viewSuperview = textField.superview;
        NSString *maskText = [NSString stringWithFormat:@"%@", form.mask[viewSuperview.tag]];
        
        if (maskText.length > 0) {
            VMaskTextField *vmaskTextField = (VMaskTextField *)textField;
            
            
            return  [vmaskTextField shouldChangeCharactersInRange:range replacementString:string];
        } else {
            return YES;
        }
    }
    return YES;
}
#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self openCameraControls:UIImagePickerControllerSourceTypeCamera];
    } else if (buttonIndex == 1) {
        [self openCameraControls:UIImagePickerControllerSourceTypePhotoLibrary];
    } else {
        
    }
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
}
#pragma mark - UIImagePicker Controller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    UIImage *imgTaken = (UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    float divisionFactor = 10.f;
    
    float imgSizeWidht = imgTaken.size.width;
    float imgSizeHeight = imgTaken.size.height;
    
    if (imgSizeWidht > imgSizeHeight) {
        if (imgSizeWidht <= 900) {
            divisionFactor = 5.f;
        }
    } else {
        if (imgSizeHeight <= 900) {
            divisionFactor = 5.f;
        }
    }
    
    UIImage *resizedImage = [UIImage imageWithImage:imgTaken scaledToSize:CGSizeMake(imgSizeWidht/divisionFactor, imgSizeHeight/divisionFactor)];
    
    NSString *encodedString = [UIImagePNGRepresentation(resizedImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    if (encodedString.length > 0) {
    
        _photos = @[encodedString];
        _infos = _photos;
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_tblView reloadData];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

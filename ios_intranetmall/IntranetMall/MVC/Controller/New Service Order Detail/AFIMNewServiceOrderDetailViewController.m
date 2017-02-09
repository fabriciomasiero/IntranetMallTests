//
//  AFIMNewServiceOrderDetailViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMNewServiceOrderDetailViewController.h"

@interface AFIMNewServiceOrderDetailViewController ()

@end

@implementation AFIMNewServiceOrderDetailViewController

#pragma mark - View Dids Loads
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UserServiceType *serviceType = _addictedServiceOrder.serviceType;
    [self setTitle:serviceType.serviceDescription];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self getUserWithCompletion:^(AFIMUser *user) {
        _serviceOrderTypeDetail = [[AFIMNewServiceOrderTypeDetail alloc] init];
        _user = user;
        [_tblView setDelegate:self];
        [_tblView setDataSource:self];
        [_tblView reloadData];
    }];
}

#pragma mark - PROCEEDING

- (void)prepareToProceed {
    if (_addictedServiceOrder.serviceType.observationRequired) {
        if (_addictedServiceOrder.serviceOrderDescription.length < 3) {
            [self showDefaultAlertView:@"Atenção" andMessage:@"Adicione uma descrição a sua ordem de serviço!" completionAction:^(NSString *action) {
                
            }];
            return;
        }
    }
    if (_addictedServiceOrder.requesterName.length < 3) {
        [self showDefaultAlertView:@"Atenção" andMessage:@"Adicione um solicitante a sua ordem de serviço!" completionAction:^(NSString *action) {
            
        }];
        return;
    }
    
    if ([_addictedServiceOrder.users count] == 0) {
        [self showDefaultAlertView:@"Atenção" andMessage:@"Adicione pessoas autorizadas a realizar essa ordem de serviço!" completionAction:^(NSString *action) {
            
        }];
        return;
    }
    if (_addictedServiceOrder.serviceType.attachmentRequired) {
        if ([_addictedServiceOrder.files count] == 0) {
            [self showDefaultAlertView:@"Atenção" andMessage:@"Adicione arquivos a sua ordem de serviço!" completionAction:^(NSString *action) {
                
            }];
            return;
        }
    }
    [self callSaveServiceOrderApi];
    
}
#pragma mark - Save API & CoreData
- (void)callSaveServiceOrderApi {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFIMServiceOrder saveServiceOrder:_addictedServiceOrder andCompletion:^(AFIMServiceOrder *newServiceOrder) {
        
        [[AFDatabaseManager sharedManager] createNewServiceOrder:_addictedServiceOrder withNewDictionaryServiceOrder:newServiceOrder];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *message = [NSString stringWithFormat:@"Ordem de serviço n° %@ criada com sucesso!", newServiceOrder.serviceOrderId];
        
        [self showDefaultAlertView:@"Atenção" andMessage:message completionAction:^(NSString *action) {
            [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
        }];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showDefaultAlertView:@"Atenção" andMessage:error.localizedDescription completionAction:^(NSString *action) {
            
        }];
    }];
}

#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    CGFloat size = 0.f;
    CGFloat sizeName = 140.f;
    NSString *shoppingNameLuc = [NSString stringWithFormat:@"%@ | LUC %@", _user.company, _user.luc];
    if (shoppingNameLuc.length > 36) {
        sizeName = 170.f;
    }
    switch (row) {
        case 0:
            size = sizeName;
            break;
        case 1:
            size = 64.f;
            break;
        case 2:
            size = 118.f;
            break;
        case 3:
            size = 80.f;
            break;
        case 4:
            size = 80.f;
            break;
        case 5:
            size = 80.f;
            break;
        case 6:
            if ([_addictedServiceOrder.loggedUser isAdmin]) {
                size = 100.f;
            } else {
                size = 0.f;
            }
            break;
        default:
            size = 0.f;
            break;
    }
    return size;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"CellShoppingInfo";
        
        AFIMNewServiceOrderDetailCellTableViewCell *cell = (AFIMNewServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMNewServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        NSString *shoppingNameLuc = [NSString stringWithFormat:@"%@ | LUC %@", _user.company, _user.luc];
        
        [cell.lblCellShoppingInfoShoppingName setNumberOfLines:2];
        [cell.lblCellShoppingInfoShoppingName setText:shoppingNameLuc];
        [cell.txtFieldCellShoppingInfoShopkeeper setText:_user.username];
        [cell.txtFieldCellShoppingInfoPhone setText:_user.phone];
        [cell.txtFieldCellShoppingInfoEmail setText:_user.email];
        
        return cell;
    } else if (indexPath.row == 1) {
        static NSString *CellIdentifier = @"CellService";
        
        AFIMNewServiceOrderDetailCellTableViewCell *cell = (AFIMNewServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMNewServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        UserServiceType *serviceType = _addictedServiceOrder.serviceType;
        [cell.lblCellServiceService setText:serviceType.serviceDescription];
        
        return cell;
    } else if (indexPath.row == 2) {
        static NSString *CellIdentifier = @"CellDate";
        
        AFIMNewServiceOrderDetailCellTableViewCell *cell = (AFIMNewServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMNewServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        [cell.lblCellDateInitialDate setText:[NSString stringGetDayDate:_addictedServiceOrder.initialDate]];
        [cell.lblCellDateFinalDate setText:[NSString stringGetDayDate:_addictedServiceOrder.finalDate]];
        [cell.lblCellDateInitialHour setText:[NSString stringGetHourDate:_addictedServiceOrder.initialHour]];
        [cell.lblCellDateFinalHour setText:[NSString stringGetHourDate:_addictedServiceOrder.finalHour]];
        
        
        return cell;
    } else if (indexPath.row == 3) {
        static NSString *CellIdentifier = @"CellDescription";
        
        AFIMNewServiceOrderDetailCellTableViewCell *cell = (AFIMNewServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMNewServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        [cell.txtViewCellDescriptionDescription setTag:indexPath.row];
        [cell.txtViewCellDescriptionDescription setDelegate:self];
        cell.txtViewCellDescriptionDescription.contentInset = UIEdgeInsetsMake(-4.f,-4.f,0.f,0.f);
        if (cell.txtViewCellDescriptionDescription.text.length == 0) {
            [cell.txtViewCellDescriptionDescription setText:@"Detalhes..."];
            [cell.txtViewCellDescriptionDescription setTextColor:[UIColor lightGrayColor]];
        }
        
        return cell;
    } else if (indexPath.row == 4) {
        static NSString *CellIdentifier = @"CellAdd";
        
        AFIMNewServiceOrderDetailCellTableViewCell *cell = (AFIMNewServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMNewServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        [cell.viewCellAddUser setUserInteractionEnabled:YES];
        [cell.viewCellAddUser addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(insertUser:)]];
        
        
        [cell.viewCellAddFile setUserInteractionEnabled:YES];
        [cell.viewCellAddFile addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(insertFile:)]];
        
        
        NSString *peopleText = @"pessoas";
        if ([_addictedServiceOrder.users count] <= 1) {
            peopleText = @"pessoa";
        }
        NSString *fileText = @"arquivos";
        if ([_addictedServiceOrder.files count] <= 1) {
            fileText = @"arquivo";
        }
        [cell.lblCellAddUserCount setText:[NSString stringWithFormat:@"%lu %@", (unsigned long)[_addictedServiceOrder.users count], peopleText]];
        [cell.lblCellAddFileCount setText:[NSString stringWithFormat:@"%lu %@", (unsigned long)[_addictedServiceOrder.files count], fileText]];
        
        
        return cell;
    } else if (indexPath.row == 5) {
        static NSString *CellIdentifier = @"CellRequester";
        
        AFIMNewServiceOrderDetailCellTableViewCell *cell = (AFIMNewServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMNewServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        [cell.txtFieldCellRequesterRequester setTag:indexPath.row];
        [cell.txtFieldCellRequesterRequester setDelegate:self];
        
        
        return cell;
    } else if (indexPath.row == 6) {
        static NSString *CellIdentifier = @"CellRequesterDestination";
        
        AFIMNewServiceOrderDetailCellTableViewCell *cell = (AFIMNewServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMNewServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        if (_serviceOrderTypeDetail.store) {
            [cell.viewCellRequesterDestinationContentFirstItem setHidden:NO];
        } else {
            [cell.viewCellRequesterDestinationContentFirstItem setHidden:YES];
        }
        
        if (_serviceOrderTypeDetail.shopping) {
            [cell.viewCellRequesterDestinationContentSecondItem setHidden:NO];
        } else {
            [cell.viewCellRequesterDestinationContentSecondItem setHidden:YES];
        }
        
        [cell.lblCellRequesterDestinationUserType setText:_addictedServiceOrder.userDestinationTypeName];
        [cell.viewCellRequesterDestinationBackgroundFirstItem setUserInteractionEnabled:YES];
        [cell.viewCellRequesterDestinationBackgroundFirstItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectStore:)]];
        
        [cell.viewCellRequesterDestinationBackgroundSecondItem setUserInteractionEnabled:YES];
        [cell.viewCellRequesterDestinationBackgroundSecondItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectShopping:)]];
        
        [cell.lblCellRequesterDestinationFirstItemTitle setUserInteractionEnabled:YES];
        [cell.lblCellRequesterDestinationFirstItemTitle addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectStore:)]];
        
        [cell.lblCellRequesterDestinationSecondItemTitle setUserInteractionEnabled:YES];
        [cell.lblCellRequesterDestinationSecondItemTitle addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectShopping:)]];
        
        [cell.lblCellRequesterDestinationUserType setUserInteractionEnabled:YES];
        [cell.lblCellRequesterDestinationUserType addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRequesterDestiny:)]];
        
        [cell.viewCellRequesterDestinationUserType setUserInteractionEnabled:YES];
        [cell.viewCellRequesterDestinationUserType addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRequesterDestiny:)]];
        
        
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"Cell";
        
        AFIMNewServiceOrderDetailCellTableViewCell *cell = (AFIMNewServiceOrderDetailCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AFIMNewServiceOrderDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self.view endEditing:YES];
}

#pragma mark - UIImagePicker Callout
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
        NSData *imgData = UIImageJPEGRepresentation(imgTaken, 1.0);
        
        AFFile *file = [[AFFile alloc] initWithFile:resizedImage fileExtension:@".png" fileEncoded:encodedString fileName:@"fileImageIntranetMall" bytes:[imgData length]];
        
        
        NSMutableArray *mutablePhotos = [[NSMutableArray alloc] init];
        [mutablePhotos addObjectsFromArray:[_addictedServiceOrder.files mutableCopy]];
        [mutablePhotos addObject:file];
        
        NSArray *files = [NSArray arrayWithArray:[mutablePhotos mutableCopy]];
        [_addictedServiceOrder setFiles:files];
        
    } else {
        [self showDefaultAlertView:@"Atenção" andMessage:@"Ocorreu um erro ao processar a imagem, tente novamente" completionAction:^(NSString *action) {
            
        }];
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_tblView reloadData];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIButton Actions
- (IBAction)proceed:(UIButton *)sender {
    [self.view endEditing:YES];
    
    [self prepareToProceed];
}

- (void)insertUser:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"showNewAuthorizedUser" sender:_addictedServiceOrder.users];
    
}
- (void)insertFile:(UITapGestureRecognizer *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Escolha o que quer compartilhar:" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolher da biblioteca", nil];
    [actionSheet showInView:self.view];
}

- (void)selectStore:(UITapGestureRecognizer *)sender {
    [_addictedServiceOrder setUserDestinationTypeName:@"Selecione o tipo de usuário"];
    [_addictedServiceOrder setDestinationId:@(1)];
    [_serviceOrderTypeDetail setShopping:NO];
    [_serviceOrderTypeDetail setStore:YES];
    [_tblView reloadData];
}
- (void)selectShopping:(UITapGestureRecognizer *)sender {
    [_addictedServiceOrder setUserDestinationTypeName:@"Selecione o tipo de usuário"];
    [_addictedServiceOrder setDestinationId:@(2)];
    [_serviceOrderTypeDetail setShopping:YES];
    [_serviceOrderTypeDetail setStore:NO];
    [_tblView reloadData];
}

- (void)showRequesterDestiny:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    if ([_addictedServiceOrder.loggedUser.userType isEqualToNumber:_addictedServiceOrder.destinationId]) {
        [self showRequestersDestionation:@[[NSString stringWithFormat:@"%@ - %@", _addictedServiceOrder.loggedUser.username, _addictedServiceOrder.loggedUser.login]]];
    } else {
        [_addictedServiceOrder setUserDestinationTypeName:@"Nenhum usuário encontrado para esse tipo"];
        [_tblView reloadData];
    }
}

- (void)showRequestersDestionation:(NSArray *)contents {
    _actionSheetStringPicker = [[ActionSheetStringPicker alloc] initWithTitle:@"Tipo de Usuário" rows:contents initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [_addictedServiceOrder setUserDestinationTypeName:selectedValue];
        [_tblView reloadData];
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:_tblView];
    [_actionSheetStringPicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"Selecionar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetStringPicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetStringPicker showActionSheetPicker];

}
#pragma mark - AFIMAuthorizedUsersListDelegate Delegate
- (void)authorizedUsersList:(NSArray *)authorizedUsers {
    [_addictedServiceOrder setUsers:authorizedUsers];
    [_tblView reloadData];
}

#pragma mark - UITextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Detalhes..."]) {
        textView.text = @"";
        textView.textColor = [UIColor darkGrayColor]; //optional
    }
    //    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Detalhes...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [_addictedServiceOrder setServiceOrderDescription:textView.text];
    //    [textView resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_addictedServiceOrder setRequesterName:textField.text];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
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
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showNewAuthorizedUser"]) {
        AFIMAuthorizedUsersListViewController *aVc = [segue destinationViewController];
        [aVc setAlreadySelectedUsers:sender];
        [aVc setAuthorizedUsersListDelegate:self];
    }
}


@end

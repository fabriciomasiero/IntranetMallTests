//
//  AFIMServiceOrderConsultViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderConsultViewController.h"
#import "AFIMNewServiceOrderCellTableViewCell.h"
#import "AFIMServiceOrder.h"
#import "AFIMServiceOrderConsultService.h"
#import "AFIMServiceOrderStatus.h"
#import "AFIMServiceOrderConsultListViewController.h"

@interface AFIMServiceOrderConsultViewController ()

@end

@implementation AFIMServiceOrderConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserWithCompletion:^(AFIMUser *user) {
        _user = user;
    }];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tblView setDelegate:self];
    [_tblView setDataSource:self];
    [self configureServiceOrderConsult];
    [self preparePickerGestures];
    [self setTitle:@"Consultar OS"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}

- (void)configureServiceOrderConsult {
    if (!_serviceOrderConsult) {
        _serviceOrderConsult = [[AFIMServiceOrderConsult alloc] init];
    }
    [_serviceOrderConsult setServicesTypeTitles:@[@"STATUS DO SERVIÇO", @"SERVIÇOS"]];
    [_serviceOrderConsult setServicesStatus:[AFIMServiceOrderConsultService insertServicesList:[AFIMServiceOrder getStatusList]]];
    [_serviceOrderConsult setServices:[AFIMServiceOrderConsultService insertServicesList:[UserServiceType all]]];
    [_tblView reloadData];
}
#pragma mark - Organizers
- (void)preparePickerGestures {
    
    [_lblDate setUserInteractionEnabled:YES];
    [_lblDate addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDate:)]];
    
    [_lblHour setUserInteractionEnabled:YES];
    [_lblHour addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHour:)]];
    
    
}

#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_serviceOrderConsult.servicesTypeTitles count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _serviceOrderConsult.servicesTypeTitles[section];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 55.f)];
    [view setBackgroundColor:[UIColor colorWithHexString:@"F2F2F2"]];
    
    UIView *viewInside = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, view.frame.size.height - 1.f)];
    [viewInside setBackgroundColor:[UIColor whiteColor]];
    
    [view addSubview:viewInside];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0.f, self.view.frame.size.width - 20.f, viewInside.frame.size.height)];
    [lblTitle setText:_serviceOrderConsult.servicesTypeTitles[section]];
    
    [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.f]];
    [lblTitle setTextColor:[UIColor darkGrayColor]];
    
    [viewInside addSubview:lblTitle];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [_serviceOrderConsult.servicesStatus count];
    } else {
        return [_serviceOrderConsult.services count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    AFIMNewServiceOrderCellTableViewCell *cell = (AFIMNewServiceOrderCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMNewServiceOrderCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.section == 0) {
        AFIMServiceOrderConsultService *service = _serviceOrderConsult.servicesStatus[indexPath.row];
        
        
        NSString *text = @"";
        if ([service.value isKindOfClass:[NSString class]]) {
            text = service.value;
        } else {
            AFIMServiceOrderStatus *serviceType = service.value;
            text = serviceType.title;
        }
        
        [cell.lblCellInfo setText:text];
        
        [UIView animateWithDuration:.5f animations:^{
            if (service.selected == YES) {
                [cell.viewBorderContent setHidden:NO];
            } else {
                [cell.viewBorderContent setHidden:YES];
            }
        }];
    } else {
        AFIMServiceOrderConsultService *service = _serviceOrderConsult.services[indexPath.row];
        
        NSString *text = @"";
        if ([service.value isKindOfClass:[NSString class]]) {
            text = service.value;
        } else {
            UserServiceType *serviceType = (UserServiceType *)service.value;
            text = serviceType.serviceDescription;
        }
        
        [cell.lblCellInfo setText:text];
        
        [UIView animateWithDuration:.5f animations:^{
            if (service.selected == YES) {
                [cell.viewBorderContent setHidden:NO];
            } else {
                [cell.viewBorderContent setHidden:YES];
            }
        }];

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self selectServiceGroup:indexPath];
//    [self performSegueWithIdentifier:@"showCircularInfo" sender:circular];
    
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
- (void)selectServiceGroup:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            for (AFIMServiceOrderConsultService *s in _serviceOrderConsult.servicesStatus) {
                if (s.selected) {
                    [s setSelected:NO];
                } else {
                    [s setSelected:YES];
                }
            }
        } else {
            AFIMServiceOrderConsultService *service = _serviceOrderConsult.servicesStatus[indexPath.row];
            [service setSelected:YES];
        }
    } else {
        if (indexPath.row == 0) {
            for (AFIMServiceOrderConsultService *s in _serviceOrderConsult.services) {
                if (s.selected) {
                    [s setSelected:NO];
                } else {
                    [s setSelected:YES];
                }
            }
        } else {
            AFIMServiceOrderConsultService *service = _serviceOrderConsult.services[indexPath.row];
            [service setSelected:YES];
        }
    }
    [_tblView reloadData];

    
}

#pragma mark - Button Actions & Gestures
- (IBAction)consult:(UIButton *)sender {
    
    if (!_serviceOrderConsult.date) {
        [self showDefaultAlertView:@"Atenção" andMessage:@"É necessário inserir uma data inicial." completionAction:^(NSString *action) {
            
        }];
        return;
    }
    if (!_serviceOrderConsult.hour) {
        [self showDefaultAlertView:@"Atenção" andMessage:@"É necessário inserir uma data final." completionAction:^(NSString *action) {
            
        }];
        return;
    }
    if ([_serviceOrderConsult.servicesStatus count] == 0 && [_serviceOrderConsult.services count] == 0) {
        [self showDefaultAlertView:@"Atenção" andMessage:@"É necessário filtar por tipos de serviço." completionAction:^(NSString *action) {
            
        }];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == YES"];
    
    NSArray *servicesStatus = [_serviceOrderConsult.servicesStatus filteredArrayUsingPredicate:predicate];
    NSArray *servicesTypes = [_serviceOrderConsult.services filteredArrayUsingPredicate:predicate];
    
//    NSMutableArray *mutableServices = [[NSMutableArray alloc] init];
//    [mutableServices addObjectsFromArray:servicesStatus];
//    [mutableServices addObjectsFromArray:servicesTypes];
    
    
    [AFIMServiceOrder consultServiceOrder:_serviceOrderConsult withServices:servicesStatus servicesTypes:servicesTypes user:_user andCompletion:^(NSArray *serviceOrders) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([serviceOrders count] > 0) {
            [self performSegueWithIdentifier:@"showServiceOrderConsultList" sender:serviceOrders];
        } else {
            [self showDefaultAlertView:@"Atenção" andMessage:@"Parece que não existem OS nessas condições" completionAction:^(NSString *action) {
                
            }];
        }
        
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showDefaultAlertView:@"Atenção" andMessage:error.localizedDescription completionAction:^(NSString *action) {
            
        }];
    }];
}
- (void)showDate:(UITapGestureRecognizer *)sender {
    [self createDatePickerWithTitle:@"Data Inicial" datePickerMode:UIDatePickerModeDate selectedDate:_serviceOrderConsult.date minimumDate:[NSDate dateWithTimeIntervalSince1970:0] maximumDate:[NSDate date] withCompletion:^(NSDate *date) {
        [_lblDate setText:[NSString stringGetDayDate:date]];
        [_serviceOrderConsult setDate:date];
    } failure:^(ActionSheetDatePicker *picker) {
        
    }];
}
- (void)showHour:(UITapGestureRecognizer *)sender {
    if (_serviceOrderConsult.date) {
        [self createDatePickerWithTitle:@"Data Final" datePickerMode:UIDatePickerModeDate selectedDate:_serviceOrderConsult.hour minimumDate:_serviceOrderConsult.date maximumDate:[NSDate date] withCompletion:^(NSDate *date) {
            [_lblHour setText:[NSString stringGetDayDate:date]];
            [_serviceOrderConsult setHour:date];
        } failure:^(ActionSheetDatePicker *picker) {
        
        }];
    }
}
#pragma mark - Create Date Picker
- (void)createDatePickerWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate withCompletion:(void (^)(NSDate *date))completion failure:(void (^)(ActionSheetDatePicker *picker))failure {
    
    if (!selectedDate) {
        selectedDate = [NSDate date];
    }
    
    
    
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        
        NSDate *d = (NSDate *)selectedDate;
        NSString *type = [NSString stringGetDayDate:d];
//        NSDate *date = [NSDate dateFromStringShortDayMode:type];
        if (datePickerMode == UIDatePickerModeTime) {
            type = [NSString stringGetHourDate:d];
        }
        
        completion(d);
        
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        failure(picker);
    } origin:_lblDate];
    
    [_actionSheetDatePicker setMaximumDate:maximumDate];
//    [_actionSheetDatePicker setMinimumDate:minimumDate];
    [_actionSheetDatePicker setMinuteInterval:30];
    [_actionSheetDatePicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"Selecionar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetDatePicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetDatePicker showActionSheetPicker];
    
    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showServiceOrderConsultList"]) {
        AFIMServiceOrderConsultListViewController *consultListVc = [segue destinationViewController];
        [consultListVc setServiceOrdersList:(NSArray *)sender];
    }
}


@end

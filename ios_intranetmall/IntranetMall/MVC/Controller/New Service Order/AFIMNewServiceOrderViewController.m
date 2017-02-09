//
//  AFIMNewServiceOrderViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMNewServiceOrderViewController.h"

@interface AFIMNewServiceOrderViewController ()

@end

@implementation AFIMNewServiceOrderViewController

#pragma mark - Initializations
- (void)viewDidLoad {
    [super viewDidLoad];
    _addictedServiceOrder = [[AFIMNewServiceOrder alloc] init];
    [self configureLabelsTexts];
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setTitle:@"Nova OS"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_tblView setDelegate:self];
    [_tblView setDataSource:self];
    [self prepareToOrganizeHeaders];
    [self preparePickerGestures];
    
}


#pragma mark - Organizers
- (void)preparePickerGestures {
    
    [_lblInitialDate setUserInteractionEnabled:YES];
    [_lblInitialDate addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInitialDate:)]];
    
    [_lblFinalDate setUserInteractionEnabled:YES];
    [_lblFinalDate addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFinalDate:)]];
    
    [_lblInitialHour setUserInteractionEnabled:YES];
    [_lblInitialHour addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInitialHour:)]];
    
    [_lblFinalHour setUserInteractionEnabled:YES];
    [_lblFinalHour addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFinalHour:)]];
    
}
- (void)prepareToOrganizeHeaders {
    NSArray *sectors = [UserSector all];
    NSMutableArray *organizing = [[NSMutableArray alloc] init];
    
    for (UserSector *u in sectors) {
        NSMutableArray *services = [[NSMutableArray alloc] init];
        for (UserServiceType *s in [u.serviceTypes allObjects]) {
            AFIMListOrderGroups *serviceItem = [[AFIMListOrderGroups alloc] initWithValue:s andSelectionState:NO isTypeKindHeader:NO withServices:nil];
            [services addObject:serviceItem];
        }
        AFIMListOrderGroups *item = [[AFIMListOrderGroups alloc] initWithValue:u andSelectionState:NO isTypeKindHeader:YES withServices:[NSArray arrayWithArray:[services mutableCopy]]];
        
        [organizing addObject:item];
    }
    _infos = [NSArray arrayWithArray:[organizing mutableCopy]];
    [_tblView reloadData];
}
- (void)configureLabelsTexts {
    [_lblInitialDate setText:[_addictedServiceOrder textForItem:[NSString stringGetDayDate:_addictedServiceOrder.initialDate]]];
    [_lblFinalDate setText:[_addictedServiceOrder textForItem:[NSString stringGetDayDate:_addictedServiceOrder.finalDate]]];
    [_lblInitialHour setText:[_addictedServiceOrder textForItem:[NSString stringGetHourDate:_addictedServiceOrder.initialHour]]];
    [_lblFinalHour setText:[_addictedServiceOrder textForItem:[NSString stringGetHourDate:_addictedServiceOrder.finalHour]]];
}

#pragma mark - Get Next Available Date
- (NSDate *)getNextAvailableDate:(NSDate *)d {
    NSString *type = [NSString stringGetDayDate:d];
    NSDate *date = [NSDate dateFromStringShortDayMode:type];
    UserCalendar *calendar = [UserCalendar find:@"date == %@", date];
    if (calendar) {
        if (calendar.holiday) {
            [self getNextAvailableDate:[NSDate getDatePlusDay:d]];
        } else if (!calendar.usefulDay) {
            [self getNextAvailableDate:[NSDate getDatePlusDay:d]];
        }
    }
    return d;
}
- (NSDate *)getNextAvailableHour:(NSDate *)d {
    NSString *type = [NSString stringGetDayDate:d];
    NSDate *date = [NSDate dateFromStringShortDayMode:type];
    UserCalendar *calendar = [UserCalendar find:@"date == %@", date];
    if (calendar) {
        if (calendar.holiday) {
            [self getNextAvailableDate:[NSDate getDatePlusDay:d]];
        } else if (!calendar.usefulDay) {
            [self getNextAvailableDate:[NSDate getDatePlusDay:d]];
        }
    }
    return d;
}

#pragma mark - Expand Item
- (void)expandItem:(NSInteger)index {
    
    AFIMListOrderGroups *orderGroup = _infos[index];
    for (AFIMListOrderGroups *og in _infos) {
        if (orderGroup != og) {
            [og setSelected:NO];
            
        }
        for (AFIMListOrderGroups *oInside in og.services) {
            [oInside setSelected:NO];
        }
    }
    
    
    orderGroup.selected = !orderGroup.selected;
        [_tblView reloadData];
    
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
        [_tblView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
- (void)selectServiceGroup:(NSIndexPath *)indexPath {
    AFIMListOrderGroups *orderGroup = _infos[indexPath.section];
    
    for (AFIMListOrderGroups *s in orderGroup.services) {
        [s setSelected:NO];
    }
    
    
    UserSector *sector = (UserSector *)orderGroup.value;
    AFIMListOrderGroups *service = orderGroup.services[indexPath.row];
    UserServiceType *serviceType = (UserServiceType *)service.value;
    
    [service setSelected:YES];
    
    [_addictedServiceOrder setUserSector:sector];
    [_addictedServiceOrder setServiceType:serviceType];
    
    if (!_addictedServiceOrder.initialDate) {
        [_addictedServiceOrder setInitialDate:[self getNextAvailableDate:[NSDate date]]];

        [self configureLabelsTexts];
    }
    
    [_tblView reloadData];
}

#pragma mark - Prepare To Proceed
- (void)prepareToProceed {
    [_lblInitialDate setTextColor:[UIColor darkGrayColor]];
    [_lblFinalDate setTextColor:[UIColor darkGrayColor]];
    [_lblInitialHour setTextColor:[UIColor darkGrayColor]];
    [_lblFinalHour setTextColor:[UIColor darkGrayColor]];
    NSDictionary *dic = [_addictedServiceOrder serviceIncompleted];
    if (dic) {
        NSString *alert = dic[@"alert"];
        AFIMNewServiceOrderType type = [dic[@"type"] integerValue];
        
        [self showDefaultAlertView:@"Atenção" andMessage:alert completionAction:^(NSString *action) {
            
        }];
        
        switch (type) {
            case AFIMNewServiceOrderTypeInitialDate:
                [_lblInitialDate setTextColor:[UIColor blackColor]];
                [_lblFinalDate setTextColor:[UIColor darkGrayColor]];
                [_lblInitialHour setTextColor:[UIColor darkGrayColor]];
                [_lblFinalHour setTextColor:[UIColor darkGrayColor]];
                break;
            case AFIMNewServiceOrderTypeFinalDate:
                [_lblInitialDate setTextColor:[UIColor darkGrayColor]];
                [_lblFinalDate setTextColor:[UIColor blackColor]];
                [_lblInitialHour setTextColor:[UIColor darkGrayColor]];
                [_lblFinalHour setTextColor:[UIColor darkGrayColor]];
                break;
            case AFIMNewServiceOrderTypeInitialHour:
                [_lblInitialDate setTextColor:[UIColor darkGrayColor]];
                [_lblFinalDate setTextColor:[UIColor darkGrayColor]];
                [_lblInitialHour setTextColor:[UIColor blackColor]];
                [_lblFinalHour setTextColor:[UIColor darkGrayColor]];
                break;
                
            case AFIMNewServiceOrderTypeFinalHour:
                [_lblInitialDate setTextColor:[UIColor darkGrayColor]];
                [_lblFinalDate setTextColor:[UIColor darkGrayColor]];
                [_lblInitialHour setTextColor:[UIColor darkGrayColor]];
                [_lblFinalHour setTextColor:[UIColor blackColor]];
                break;
            default:
                break;
        }
        
    } else {
        [self getUserWithCompletion:^(AFIMUser *user) {
            [_addictedServiceOrder setLoggedUser:user];
            [self performSegueWithIdentifier:@"showNewServiceOrderDetail" sender:_addictedServiceOrder];
        }];
        
    }
}

#pragma mark - Create Date Picker
- (void)createDatePickerWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)datePickerMode selectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate withCompletion:(void (^)(NSDate *date))completion failure:(void (^)(ActionSheetDatePicker *picker))failure {
    
    if (selectedDate == nil && minimumDate == nil && maximumDate == nil) {
        selectedDate = [NSDate getMaximumDateYearAgo];
        minimumDate = [NSDate getMinimumHour];
        maximumDate = [NSDate getMaximumHour];
    }
    
    
    _actionSheetDatePicker = [[ActionSheetDatePicker alloc] initWithTitle:title datePickerMode:datePickerMode selectedDate:selectedDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        
        NSDate *d = (NSDate *)selectedDate;
        NSString *type = [NSString stringGetDayDate:d];
        NSDate *date = [NSDate dateFromStringShortDayMode:type];
        if (datePickerMode == UIDatePickerModeTime) {
            type = [NSString stringGetHourDate:d];
        }
        NSString *stringAlert = [NSString stringWithFormat:@"Aparentemente a data escolhida (%@) não é um dia útil", type];
        
        
        UserCalendar *calendar = [UserCalendar find:@"date == %@", date];
        if (calendar) {
            if (calendar.holiday) {
                
                [self showDefaultAlertView:@"Atenção" andMessage:stringAlert completionAction:^(NSString *action) {
                    [_actionSheetDatePicker showActionSheetPicker];
                }];
            } else if (!calendar.usefulDay) {
                
                [self showDefaultAlertView:@"Atenção" andMessage:stringAlert completionAction:^(NSString *action) {
                    [_actionSheetDatePicker showActionSheetPicker];
                }];
            } else {
                completion(d);
            }
        } else {
            completion(d);
        }
        
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        failure(picker);
    } origin:_lblInitialDate];
    
    [_actionSheetDatePicker setMaximumDate:maximumDate];
    [_actionSheetDatePicker setMinimumDate:minimumDate];
    [_actionSheetDatePicker setMinuteInterval:30];
    [_actionSheetDatePicker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"Selecionar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetDatePicker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:nil action:nil]];
    [_actionSheetDatePicker showActionSheetPicker];

    
}
#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_infos count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *CellIdentifier = @"CellSectionHeader";
    AFIMNewServiceOrderCellTableViewCell *cell = (AFIMNewServiceOrderCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    AFIMListOrderGroups *orderGroup = _infos[section];
    UserSector *sector = (UserSector *)orderGroup.value;
    [cell.lblHeaderInfo setText:sector.sectorDescription];
    [cell.imgHeaderInfo setUserInteractionEnabled:YES];
    [cell.imgHeaderInfo setTag:section];
    [cell.imgHeaderInfo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandItemImage:)]];
    
    [cell.lblHeaderInfo setUserInteractionEnabled:YES];
    [cell.lblHeaderInfo setTag:section];
    [cell.lblHeaderInfo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandItemLabel:)]];
    
    
    [UIView animateWithDuration:.5f animations:^{
        if (orderGroup.selected == YES) {
            [cell.imgHeaderInfo setImage:[UIImage imageNamed:@"imgOpenedSection"]];
        } else {
            [cell.imgHeaderInfo setImage:[UIImage imageNamed:@"imgClosedSection"]];
        }
    }];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AFIMListOrderGroups *orderGroup = _infos[indexPath.section];
    BOOL header = (BOOL)orderGroup.header;
    BOOL selected = (BOOL)orderGroup.selected;
    if (header) {
        if (selected) {
            return 44.f;
        }
    }
    return 1.f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AFIMListOrderGroups *orderGroup = _infos[section];
    BOOL header = (BOOL)orderGroup.header;
    BOOL selected = (BOOL)orderGroup.selected;
    NSInteger count = 1.f;
    if (header) {
        if (selected) {
//            UserSector *sector = (UserSector *)orderGroup.value;
//            NSArray *serviceTypes = [sector.serviceTypes allObjects];
            NSArray *serviceTypes = orderGroup.services;

            count = [serviceTypes count];
        }
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    AFIMNewServiceOrderCellTableViewCell *cell = (AFIMNewServiceOrderCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMNewServiceOrderCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    AFIMListOrderGroups *orderGroup = _infos[indexPath.section];
    if ([orderGroup.services count] >= indexPath.row) {
        AFIMListOrderGroups *service = orderGroup.services[indexPath.row];
        UserServiceType *serviceType = (UserServiceType *)service.value;
        [cell.lblCellInfo setText:serviceType.serviceDescription];
        
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
//    [_searchBar resignFirstResponder];
    
}

#pragma mark - UIButton & Tap Gesture Actions
- (IBAction)proceed:(UIButton *)sender {
    [self prepareToProceed];
}
- (void)expandItemImage:(UITapGestureRecognizer *)sender {
    [self expandItem:sender.view.tag];
}
- (void)expandItemLabel:(UITapGestureRecognizer *)sender {
    [self expandItem:sender.view.tag];
}

- (void)showInitialDate:(UITapGestureRecognizer *)sender {
    
    if (_addictedServiceOrder.initialDate) {
    
        [self createDatePickerWithTitle:@"Data Inicial" datePickerMode:UIDatePickerModeDate selectedDate:_addictedServiceOrder.initialDate minimumDate:_addictedServiceOrder.initialDate maximumDate:[NSDate getMaximumDateYearAgo] withCompletion:^(NSDate *date) {
            [_addictedServiceOrder setInitialDate:date];
            [self configureLabelsTexts];
        } failure:^(ActionSheetDatePicker *picker) {
        
        }];
    }
}
- (void)showFinalDate:(UITapGestureRecognizer *)sender {
    NSDate *selectedDate = [NSDate date];
    if (_addictedServiceOrder.initialDate) {
        [self createDatePickerWithTitle:@"Data Final" datePickerMode:UIDatePickerModeDate selectedDate:selectedDate minimumDate:selectedDate maximumDate:[NSDate getMaximumDateYearAgo] withCompletion:^(NSDate *date) {
            [_addictedServiceOrder setFinalDate:date];
            [self configureLabelsTexts];
        } failure:^(ActionSheetDatePicker *picker) {
            
        }];
    }
}
- (void)showInitialHour:(UITapGestureRecognizer *)sender {
    if (_addictedServiceOrder.initialDate) {
        [self createDatePickerWithTitle:@"Hora inicial" datePickerMode:UIDatePickerModeTime selectedDate:[NSDate getMaximumDateYearAgo] minimumDate:[NSDate getMinimumHour] maximumDate:[NSDate getMaximumHour] withCompletion:^(NSDate *date) {
            [_addictedServiceOrder setInitialHour:date];
            [_addictedServiceOrder setFinalHour:nil];
            [self configureLabelsTexts];
        } failure:^(ActionSheetDatePicker *picker) {
            
        }];
    }
}
- (void)showFinalHour:(UITapGestureRecognizer *)sender {
    
    if (_addictedServiceOrder.initialHour) {
        if (_addictedServiceOrder.finalDate) {
            NSDate *selectedDate = [NSDate getMaximumDateYearAgo];
            NSDate *minimumDate = [NSDate getMinimumHour];
            NSDate *maximumDate = [NSDate getMaximumHour];
            if ([NSDate isSameDay:_addictedServiceOrder.initialDate asDate:_addictedServiceOrder.finalDate]) {
                selectedDate = [NSDate getHourPlusHour:_addictedServiceOrder.initialHour];
                minimumDate = selectedDate;
                maximumDate = [NSDate getMaximumHour];
            }
            [self createDatePickerWithTitle:@"Hora final" datePickerMode:UIDatePickerModeTime selectedDate:selectedDate minimumDate:minimumDate maximumDate:maximumDate withCompletion:^(NSDate *date) {
                [_addictedServiceOrder setFinalHour:date];
                [self configureLabelsTexts];
            } failure:^(ActionSheetDatePicker *picker) {
            
            }];
        }
    }
}



#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showNewServiceOrderDetail"]) {
        AFIMNewServiceOrderDetailViewController *detailVc = [segue destinationViewController];
        [detailVc setAddictedServiceOrder:(AFIMNewServiceOrder *)sender];
    }
    
}


@end

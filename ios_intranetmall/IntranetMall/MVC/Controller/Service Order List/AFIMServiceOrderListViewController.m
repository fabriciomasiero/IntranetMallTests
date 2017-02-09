//
//  AFIMServiceOrderListViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderListViewController.h"
#import "AFIMServiceOrderDetailViewController.h"

@interface AFIMServiceOrderListViewController ()

@end

@implementation AFIMServiceOrderListViewController

#pragma mark - Initial Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicMenuInitialization:@"serviceOrderView"];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [_viewButtonAddServiceOrder.layer setCornerCircle];
    [self setTitle:@"OS"];
    
    
    _btnBarCloseSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgClose"] style:UIBarButtonItemStylePlain target:self action:@selector(closeSearchBar:)];
    
    [self addRefreshControl];
    [self callServiceOrders];
    
//    [self.navigationItem setRightBarButtonItems:@[_btnBarSearch, _btnBarAction]];
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
    if ([_serviceOrders count] > 0) {
        _serviceOrders = [[AFDatabaseManager sharedManager] getRecentServiceOrders];
        _serviceOrderList = _serviceOrders;
        if (_typeSelectedOnHome > 0) {
            [self filterServiceOrders:(AFIMServiceOrderStatusType)_typeSelectedOnHome];
        }
        [_tblView reloadData];
    }
}
#pragma mark - Add Refresh Control
- (void)addRefreshControl {
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl setBackgroundColor:[UIColor colorWithHexString:@"E3E3E3"]];
    [_refreshControl setTintColor:[UIColor darkGrayColor]];
    [_refreshControl addTarget:self action:@selector(callServiceOrders) forControlEvents:UIControlEventValueChanged];
    [_tblView addSubview:_refreshControl];
}
- (void)reloadData {
    [_tblView reloadData];
    if (self.refreshControl) {
        
        NSString *title = [NSString stringWithFormat:@"Última atualização: %@", [NSString stringGetDateToShowMonth:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor darkGrayColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
    
    [_refreshControl endRefreshing];
}

#pragma mark - Search In Context
- (void)searchInContext:(NSString *)context {
    NSArray *newResults;
    _serviceOrderList = nil;
    
    
    newResults = [[AFDatabaseManager sharedManager] searchOnServiceOrder:context];
    _serviceOrderList = [NSArray arrayWithArray:newResults];
    [_tblView reloadData];
}
#pragma mark - Filtering
- (void)filterServiceOrders:(AFIMServiceOrderStatusType)type {
    
    if ((type != AFIMServiceOrderStatusTypeAll) && (type != AFIMServiceOrderStatusTypeUnknown)) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"statusId == %@", @(type)];
        
        NSArray *newOfficials = [_serviceOrders filteredArrayUsingPredicate:predicate];
        
        if ([newOfficials count] == 0) {
            [self showDefaultAlertView:@"Atenção" andMessage:@"Não foram encontrados nenhuma OS com este estado" completionAction:^(NSString *action) {
                
            }];
        }
        
        _serviceOrderList = newOfficials;
        [_tblView reloadData];
    } else {
        _typeSelectedOnHome = 0;
        _serviceOrderList = _serviceOrders;
        [_tblView reloadData];
    }
}
#pragma mark - Hide & Show Search
- (void)hidesCloseSearchBarButton {
    [UIView animateWithDuration:.1f animations:^{
        if ([self.navigationItem.rightBarButtonItems count] != 1) {
            [self.navigationItem setRightBarButtonItem:nil];
            [self.navigationItem setRightBarButtonItems:@[_btnBarSearch, _btnBarAction]];
        }
    }];
}
- (void)showsCloseSearchBarButton {
    [UIView animateWithDuration:.1f animations:^{
        [self.navigationItem setRightBarButtonItem:nil];
        [self.navigationItem setRightBarButtonItem:_btnBarCloseSearch];
    }];
}
#pragma mark - Create Actions Sheet
- (void)createActions {
    
    
    NSArray *actions;
    
    if ([_user isAdmin]) {
        actions = @[@"Aprovar O.S", @"Consultar O.S"];
    } else {
        actions = @[@"Aprovar O.S"];
    }
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Ações"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    for (NSString *title in actions)  {
        [actionSheet addButtonWithTitle:title];
    }
    
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancelar"];
    
    [actionSheet showInView:self.view];
}

#pragma mark - API Callout
- (void)callServiceOrders {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (!_user) {
        [self getUserWithCompletion:^(AFIMUser *user) {
            self.user = user;
            
        }];
    }
    [AFIMServiceOrder getServiceOrdersWithUserId:_user.userId shoppingId:_user.shoppingId userType:_user.userType andCompletion:^(NSArray *serviceOrderList) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _serviceOrderList = serviceOrderList;
        _serviceOrders = serviceOrderList;
        if (_typeSelectedOnHome > 0) {
            [self filterServiceOrders:(AFIMServiceOrderStatusType)_typeSelectedOnHome];
        }
        [self reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_serviceOrderList count] > 0) {
        if ([_tblView.backgroundView isKindOfClass:[UILabel class]]) {
            [_tblView setBackgroundView:nil];
        }
        return 1;
    } else {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
//        messageLabel.text = @"Nenhuma ordem de serviço encontrada.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        [messageLabel sizeToFit];
        
        _tblView.backgroundView = messageLabel;
//        _tblView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_serviceOrderList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    AFIMServiceOrdersCellTableViewCell *cell = (AFIMServiceOrdersCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMServiceOrdersCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    ServiceOrder *serviceOrder = _serviceOrderList[indexPath.row];
    [cell.lblServiceOrderNumber setText:[NSString stringWithFormat:@"OS %d", serviceOrder.serviceOrderId]];
    [cell.lblDate setText:[NSString stringGetDayDate:serviceOrder.initialDate]];
    
    [cell.lblServiceOrderType setText:serviceOrder.serviceType];
    [cell.lblRequester setText:serviceOrder.requesterName];
    [cell.lblEmail setText:serviceOrder.email];

    [cell.lblDescription setText:serviceOrder.serviceOrderDescription];
    cell.lblDescription.contentInset = UIEdgeInsetsMake(-7.0,0.0,0,0.0);
    
    [cell.imgStatus setImage:[UIImage imageNamed:serviceOrder.imgStatus]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ServiceOrder *serviceOrder = _serviceOrderList[indexPath.row];
    [self performSegueWithIdentifier:@"showServiceOrdeDetail" sender:serviceOrder];
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
    [_searchBar resignFirstResponder];
    
}

#pragma mark - Search Bar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text.length == 0 && [searchText isEqualToString:@""]) {
        [self showsCloseSearchBarButton];
        [self searchInContext:searchText];
        return;
    }
    if (searchText.length > 2) {
        [self searchInContext:searchText];
    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ((searchBar.text.length == 1 && [text isEqualToString:@""]) || (searchBar.text.length == 0 && [text isEqualToString:@""])) {
        [self showsCloseSearchBarButton];
    } else {
        [self hidesCloseSearchBarButton];
    }
    return YES;
}


#pragma mark - UIButtons Actions
- (IBAction)searchOnServiceOrders:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:.1f animations:^{
        if (!_searchBar) {
            _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.f, 0.f, 300.f, 44.f)];
        }
        [_searchBar setTintColor:[UIColor colorWithHexString:@"1FBBD4"]];
        [_searchBar setDelegate:self];
        self.navigationItem.titleView = nil;
        self.navigationItem.titleView = _searchBar;
        [self.navigationItem setRightBarButtonItem:nil];
        [self.navigationItem setRightBarButtonItem:_btnBarCloseSearch];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5f animations:^{
            [_searchBar becomeFirstResponder];
        }];
        
    }];
}
- (void)closeSearchBar:(UIBarButtonItem *)sender {
    [UIView animateWithDuration:.2f animations:^{
        [self setTitle:@""];
        [_searchBar removeFromSuperview];
        [_searchBar setText:@""];
        self.navigationItem.titleView = nil;
        [self.navigationItem setRightBarButtonItem:nil];
        [self.navigationItem setRightBarButtonItems:@[_btnBarSearch, _btnBarAction]];
    } completion:^(BOOL finished) {
        [self setTitle:@"OS"];
    }];
    
}
- (IBAction)actionList:(UIBarButtonItem *)sender {
    [self createActions];
}

//- (IBAction)addUser:(UIButton *)sender {
//    [self performSegueWithIdentifier:@"showOfficialEdit" sender:nil];
//}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self filterServiceOrders:AFIMServiceOrderStatusTypeInApproval];
            break;
        case 1:
            
//            [self filterServiceOrders:AFIMServiceOrderStatusTypeAll];
            [self performSegueWithIdentifier:@"showServiceOrderConsult" sender:nil];
            break;
            
        default:
            break;
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showServiceOrdeDetail"]) {
        AFIMServiceOrderDetailViewController *dVc = [segue destinationViewController];
        if ([sender isKindOfClass:[ServiceOrder class]]) {
            [dVc setServiceOrder:sender];
        }
    }
}

@end

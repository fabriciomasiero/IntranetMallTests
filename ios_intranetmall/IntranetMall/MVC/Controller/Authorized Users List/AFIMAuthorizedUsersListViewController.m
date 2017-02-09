//
//  AFIMAuthorizedUsersListViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 12/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMAuthorizedUsersListViewController.h"

@interface AFIMAuthorizedUsersListViewController ()

@end

@implementation AFIMAuthorizedUsersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tblView setDelegate:self];
    [_tblView setDataSource:self];
    [self organizeUsers];
    [_viewAddUser.layer setCornerCircle];
    
    _btnBarSave = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgSave"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAuthorizedUsersList:)];
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.navigationItem setRightBarButtonItem:_btnBarSave];
    
    [self setTitle:@"Usuários autorizados"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)organizeUsers {
    NSArray *allUsers = [[AFDatabaseManager sharedManager] getCorrectAuthorizedUsers];
    
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:allUsers];
    NSArray *arrayWithoutDuplicates = [orderedSet array];
    
    NSMutableArray *mutableUsers = [[NSMutableArray alloc] init];
    for (ServiceOrderAuthorizedUser *au in arrayWithoutDuplicates) {
        [mutableUsers addObject:[[AFIMNewServiceOrderAuthorizedUsers alloc] initWithUser:au andSelected:NO]];
    }
    
    _users = [NSArray arrayWithArray:mutableUsers];
    for (AFIMNewServiceOrderAuthorizedUsers *user in _users) {
        for (AFIMNewServiceOrderAuthorizedUsers *alreadyUser in _alreadySelectedUsers) {
            if (user.user.userIdAuthorized == alreadyUser.user.userIdAuthorized) {
                [user setSelected:YES];
            }
        }
    }
    
    [_tblView reloadData];
}


#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    AFIMAuthorizedUsersCellTableViewCell *cell = (AFIMAuthorizedUsersCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMAuthorizedUsersCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    AFIMNewServiceOrderAuthorizedUsers *user = _users[indexPath.row];
    
    [cell.lblUserName setText:user.user.name];
    [cell.lblUserDocumentInsideCountry setText:user.user.documentInsideCountry];
    [cell.lblUserEnterprise setText:user.user.enterprise];
    
    if (user.selected) {
        [cell.viewSelectUser setBackgroundColor:[UIColor colorWithHexString:@"CA2B56"]];
        [cell.viewSelectUser.layer setBorderColor:[UIColor colorWithHexString:@"CA2B56"].CGColor];
        [cell.viewSelectUser.layer setBorderWidth:0.f];
    } else {
        [cell.viewSelectUser setBackgroundColor:[UIColor whiteColor]];
        [cell.viewSelectUser.layer setBorderColor:[UIColor darkGrayColor].CGColor];
        [cell.viewSelectUser.layer setBorderWidth:.5f];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AFIMNewServiceOrderAuthorizedUsers *user = _users[indexPath.row];
    [user setSelected:!user.selected];
    
    [_tblView reloadData];
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
//    [_searchBar resignFirstResponder];
    
}

#pragma mark - UIButton Actions
- (IBAction)createNewUser:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showCreateUser" sender:nil];
}
- (void)saveAuthorizedUsersList:(UIBarButtonItem *)sender {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected == YES"];
    NSArray *users = [_users filteredArrayUsingPredicate:predicate];
    
//    if ([users count] > 0) {
        [_authorizedUsersListDelegate authorizedUsersList:users];
    [self.navigationController popViewControllerAnimated:YES];
//    }
}

#pragma mark - AFIMNewAuthorizedUserViewControllerDelegate DELEGATE
- (void)authorizedUserCreated:(AFIMNewServiceOrderAuthorizedUsers *)createdUser {
    NSMutableArray *mutableUsers = [[NSMutableArray alloc] init];
    [mutableUsers addObject:createdUser];
    [mutableUsers addObjectsFromArray:_users];
    
    
    _users = [NSArray arrayWithArray:mutableUsers];
    
    [_tblView reloadData];
    
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCreateUser"]) {
        AFIMNewAuthorizedUserViewController *userVc = [segue destinationViewController];
        [userVc setCreatedUserDelegate:self];
        
    }
}


@end

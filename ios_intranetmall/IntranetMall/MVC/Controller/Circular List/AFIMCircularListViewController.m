//
//  AFIMCircularListViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 28/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMCircularListViewController.h"
#import "AFIMCircularViewController.h"

@interface AFIMCircularListViewController ()

@end

@implementation AFIMCircularListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicMenuInitialization:@"circularListView"];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    _tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.navigationItem setRightBarButtonItem:nil];
    
    [self setTitle:@"Circulares"];
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    _btnBarCloseSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"imgClose"] style:UIBarButtonItemStylePlain target:self action:@selector(closeSearchBar:)];
    
    [self.navigationItem setRightBarButtonItem:_btnBarSearch];
    
    [self addRefreshControl];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationItem setRightBarButtonItem:_btnBarSearch];
    [self callCircularListApi];
    [_tblView setDelegate:self];
    [_tblView setDataSource:self];
}

#pragma mark - Add Refresh Control
- (void)addRefreshControl {
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl setBackgroundColor:[UIColor colorWithHexString:@"E3E3E3"]];
    [_refreshControl setTintColor:[UIColor darkGrayColor]];
    [_refreshControl addTarget:self action:@selector(callCircularListApi) forControlEvents:UIControlEventValueChanged];
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
    
    
    _circularList = nil;
    
    
    newResults = [[AFDatabaseManager sharedManager] searchOnCircular:context];
    _circularList = [NSArray arrayWithArray:newResults];
    [_tblView reloadData];
}
#pragma mark - Hide & show Bar and Search
- (void)hidesCloseSearchBarButton {
    [UIView animateWithDuration:.1f animations:^{
        if ([self.navigationItem.rightBarButtonItems count] != 1) {
            [self.navigationItem setRightBarButtonItem:nil];
            [self.navigationItem setRightBarButtonItem:_btnBarSearch];
        }
    }];
}
- (void)showsCloseSearchBarButton {
    [UIView animateWithDuration:.1f animations:^{
        [self.navigationItem setRightBarButtonItem:nil];
        [self.navigationItem setRightBarButtonItem:_btnBarCloseSearch];
    }];
}

#pragma mark - Call API
- (void)callCircularListApi {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (!_user) {
        [self getUserWithCompletion:^(AFIMUser *user) {
            self.user = user;
        }];
    }
    [AFIMCircular getCircularListWithUserId:_user.userId shoppingId:_user.shoppingId andCompletion:^(NSArray *circularList) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _circularList = circularList;
        [self reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showDefaultAlertView:@"Atenção" andMessage:error.localizedDescription completionAction:^(NSString *action) {
            
        }];
    }];
}

#pragma mark - UITableView Delegate & Datasource
#pragma mark - Table view Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_circularList count] > 0) {
        if ([_tblView.backgroundView isKindOfClass:[UILabel class]]) {
            [_tblView setBackgroundView:nil];
        }
        return 1;
    } else {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
//        messageLabel.text = @"Nenhuma circular encontrada.";
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
    return [_circularList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    AFIMCircularCellTableViewCell *cell = (AFIMCircularCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AFIMCircularCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Circular *circular = _circularList[indexPath.row];
    
    [cell.lblCircularName setText:circular.title];
    [cell.lblCircularDate setText:[NSString stringGetDayDateToShow:circular.registerDate]];
    [cell.lblCircularFirstChar setText:[circular.title substringToIndex:1]];
    
    if (circular.read) {
        [cell.lblCircularName setFont:[UIFont fontWithName:@"HelveticaNeue" size:16.f]];
        [cell.lblCircularDate setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.f]];
        [cell.viewCircular setBackgroundColor:[UIColor colorWithHexString:@"1FBBD4"]];
    } else {
        [cell.lblCircularName setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.f]];
        [cell.lblCircularDate setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.f]];
        [cell.viewCircular setBackgroundColor:[UIColor colorWithHexString:@"CA2B56"]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Circular *circular = _circularList[indexPath.row];
    [self performSegueWithIdentifier:@"showCircularInfo" sender:circular];
    
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
- (IBAction)searchButtonClicked:(UIBarButtonItem *)sender {
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
        [self.navigationItem setRightBarButtonItem:_btnBarSearch];
    } completion:^(BOOL finished) {
        [self setTitle:@"Circulares"];
    }];
    
}

- (IBAction)closeButtonClicked:(UIBarButtonItem *)sender {
    [self closeSearchBar:sender];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCircularInfo"]) {
        AFIMCircularViewController *cVc = [segue destinationViewController];
        [cVc setCircular:(Circular *)sender];
    }
}


@end

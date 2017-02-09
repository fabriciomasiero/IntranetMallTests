//
//  AFIMServiceOrderListViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFDatabaseManager.h"
#import "AFIMServiceOrdersCellTableViewCell.h"
#import "AFIMServiceOrder.h"


@interface AFIMServiceOrderListViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIActionSheetDelegate>

@property (nonatomic) NSInteger typeSelectedOnHome;


@property (strong, nonatomic) AFIMUser *user;
@property (strong, nonatomic) NSArray *serviceOrders;
@property (strong, nonatomic) NSArray *serviceOrderList;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBarAction;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBarSearch;
@property (strong, nonatomic) UIBarButtonItem *btnBarCloseSearch;
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UIView *viewButtonAddServiceOrder;
@property (strong, nonatomic) IBOutlet UIButton *btnAddServiceOrder;

- (IBAction)searchOnServiceOrders:(UIBarButtonItem *)sender;
- (IBAction)actionList:(UIBarButtonItem *)sender;
- (IBAction)addServiceOrder:(UIButton *)sender;

@end

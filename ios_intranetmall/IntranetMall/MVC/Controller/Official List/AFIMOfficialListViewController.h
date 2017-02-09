//
//  AFIMOfficialListViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMOfficialsCellTableViewCell.h"
#import "AFIMOfficials.h"
#import "AFDatabaseManager.h"
#import "CALayer+Extras.h"




@interface AFIMOfficialListViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) AFIMUser *user;
@property (strong, nonatomic) NSArray *officials;
@property (strong, nonatomic) NSArray *officialList;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBarAction;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBarSearch;
@property (strong, nonatomic) UIBarButtonItem *btnBarCloseSearch;
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UIView *viewButtonAddUser;
@property (strong, nonatomic) IBOutlet UIButton *btnAddUser;

- (IBAction)searchOnOfficials:(UIBarButtonItem *)sender;
- (IBAction)actionList:(UIBarButtonItem *)sender;
- (IBAction)addUser:(UIButton *)sender;



@end

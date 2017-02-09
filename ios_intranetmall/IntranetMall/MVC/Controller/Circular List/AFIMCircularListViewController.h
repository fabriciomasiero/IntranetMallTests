//
//  AFIMCircularListViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 28/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMCircularCellTableViewCell.h"
#import "AFIMCircular.h"
#import "AFDatabaseManager.h"

@interface AFIMCircularListViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>


@property (strong, nonatomic) NSArray *circularList;
@property (strong, nonatomic) AFIMUser *user;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBarSearch;
@property (strong, nonatomic) UIBarButtonItem *btnBarCloseSearch;


- (IBAction)searchButtonClicked:(UIBarButtonItem *)sender;

@end

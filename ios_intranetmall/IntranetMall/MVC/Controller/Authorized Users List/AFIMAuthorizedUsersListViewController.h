//
//  AFIMAuthorizedUsersListViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 12/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMAuthorizedUsersCellTableViewCell.h"
#import "AFIMNewServiceOrderAuthorizedUsers.h"
#import "ServiceOrderAuthorizedUser+CoreDataClass.h"
#import "AFIMNewServiceOrderAuthorizedUsers.h"
#import "AFIMNewAuthorizedUserViewController.h"
#import "AFDatabaseManager.h"

@protocol AFIMAuthorizedUsersListDelegate

@optional
- (void)authorizedUsersList:(NSArray *)authorizedUsers;

@end

@interface AFIMAuthorizedUsersListViewController : AFBaseViewController <UITableViewDataSource, UITableViewDelegate, AFIMNewServicerOrderAuthorizedUserCreatedDelegate>


@property (assign, nonatomic) id <AFIMAuthorizedUsersListDelegate> authorizedUsersListDelegate;

@property (strong, nonatomic) NSArray *alreadySelectedUsers;

@property (strong, nonatomic) NSArray *users;

@property (strong, nonatomic) UIBarButtonItem *btnBarSave;


@property (strong, nonatomic) IBOutlet UIView *viewAddUser;

@property (strong, nonatomic) IBOutlet UITableView *tblView;

- (IBAction)createNewUser:(UIButton *)sender;


@end

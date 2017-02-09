//
//  AFIMServiceOrderDetailViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 05/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMServiceOrderDetailCellTableViewCell.h"
#import <MWPhotoBrowser/MWPhoto.h>
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "AFIMServiceOrder.h"


@interface AFIMServiceOrderDetailViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource, MWPhotoBrowserDelegate, UITextViewDelegate>

@property (strong, nonatomic) ServiceOrder *serviceOrder;
@property (strong, nonatomic) AFIMServiceOrder *serviceOrderConsult;
@property (strong, nonatomic) AFIMUser *user;

@property (nonatomic) AFIMServiceOrderApprovalStatus approvalStatus;
@property (nonatomic) BOOL iCanComment;

@property (strong, nonatomic) NSArray *authorizedUsers;
@property (strong, nonatomic) NSArray *approvers;
@property (strong, nonatomic) NSArray *observations;
@property (strong, nonatomic) NSMutableArray *photos;


@property (strong, nonatomic) IBOutlet UITableView *tblView;


@end

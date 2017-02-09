//
//  AFIMNewServiceOrderViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMListOrderGroups.h"
#import "AFIMNewServiceOrderCellTableViewCell.h"
#import <ActionSheetPicker-3.0/ActionSheetDatePicker.h>
#import "AFIMNewServiceOrder.h"
#import "AFIMNewServiceOrderDetailViewController.h"


@interface AFIMNewServiceOrderViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *infos;

@property (strong, nonatomic) ActionSheetDatePicker *actionSheetDatePicker;

@property (strong, nonatomic) AFIMNewServiceOrder *addictedServiceOrder;


@property (strong, nonatomic) IBOutlet UILabel *lblInitialDate;
@property (strong, nonatomic) IBOutlet UILabel *lblFinalDate;
@property (strong, nonatomic) IBOutlet UILabel *lblInitialHour;
@property (strong, nonatomic) IBOutlet UILabel *lblFinalHour;


@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UIButton *btnContinue;

- (IBAction)proceed:(UIButton *)sender;

@end

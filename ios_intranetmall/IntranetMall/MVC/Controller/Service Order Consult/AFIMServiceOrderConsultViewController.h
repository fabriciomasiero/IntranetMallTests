//
//  AFIMServiceOrderConsultViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMServiceOrderConsult.h"
#import <ActionSheetPicker-3.0/ActionSheetPicker.h>

@interface AFIMServiceOrderConsultViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) AFIMUser *user;
@property (strong, nonatomic) AFIMServiceOrderConsult *serviceOrderConsult;

@property (strong, nonatomic) ActionSheetDatePicker *actionSheetDatePicker;

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblHour;

@property (strong, nonatomic) IBOutlet UIButton *btnConsult;


- (IBAction)consult:(UIButton *)sender;

@end

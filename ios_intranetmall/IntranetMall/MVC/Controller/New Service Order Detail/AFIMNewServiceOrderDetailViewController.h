//
//  AFIMNewServiceOrderDetailViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMNewServiceOrderDetailCellTableViewCell.h"
#import "AFIMNewServiceOrder.h"
#import "AFFile.h"
#import "AFIMNewServiceOrderTypeDetail.h"
#import "AFIMAuthorizedUsersListViewController.h"
#import <ActionSheetPicker-3.0/ActionSheetStringPicker.h>

@interface AFIMNewServiceOrderDetailViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, AFIMAuthorizedUsersListDelegate>


@property (strong, nonatomic) AFIMNewServiceOrder *addictedServiceOrder;
@property (strong, nonatomic) AFIMUser *user;
@property (strong, nonatomic) AFIMNewServiceOrderTypeDetail *serviceOrderTypeDetail;

@property (strong, nonatomic) ActionSheetStringPicker *actionSheetStringPicker;


@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tblView;
@property (strong, nonatomic) IBOutlet UIButton *btnContinue;


- (IBAction)proceed:(UIButton *)sender;


@end

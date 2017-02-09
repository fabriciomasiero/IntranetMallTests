//
//  AFIMOfficialDetailViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 15/12/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMOfficialEditCellTableViewCell.h"
#import "AFForm.h"
#import "AFIMOfficials.h"
#import "AFDatabaseManager.h"
#import <ActionSheetPicker-3.0/ActionSheetPicker.h>
#import "AFPostalCode.h"



typedef enum  {
    AFActionSheetFormTypeDocument,
    AFActionSheetFormTypeBirthDate,
    AFActionSheetFormTypeAdmissionDate,
    AFActionSheetFormTypeDemissionDate,
    AFActionSheetFormTypeSex
} AFActionSheetFormType;


@interface AFIMOfficialDetailViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) Official *official;

@property (strong, nonatomic) NSDate *selectedBirthDate;
@property (strong, nonatomic) NSDate *selectedAdmissionalDate;
@property (strong, nonatomic) NSDate *selecteResignedDate;


@property (strong, nonatomic) NSArray *basics;
@property (strong, nonatomic) NSArray *addresses;
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSArray *infos;



@property (strong, nonatomic) UIBarButtonItem *btnBarSave;

@property (strong, nonatomic) ActionSheetStringPicker *actionSheetStringPicker;
@property (strong, nonatomic) ActionSheetDatePicker *actionSheetDatePicker;
@property (strong, nonatomic) UIImagePickerController *imagePicker;



@property (strong, nonatomic) IBOutlet UISegmentedControl *segControl;


@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tblView;



- (IBAction)didSelectSegment:(UISegmentedControl *)sender;

@end

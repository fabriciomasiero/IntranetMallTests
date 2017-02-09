//
//  AFIMOfficialEditCellTableViewCell.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 15/12/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VMaskTextField/VMaskTextField.h>

@interface AFIMOfficialEditCellTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imgViewUniqueConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imgViewFirstConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imgViewSecondConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imgViewFirstUniqueCheckboxConstraint;


#pragma mark - Cell Unique
@property (strong, nonatomic) IBOutlet UILabel *lblTitleUnique;
@property (strong, nonatomic) IBOutlet VMaskTextField *txtFieldUnique;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewUnique;
@property (strong, nonatomic) IBOutlet UIView *viewUniqueBack;
@property (strong, nonatomic) IBOutlet UIView *viewTxtBackUnique;

#pragma mark - Cell Dual
@property (strong, nonatomic) IBOutlet UILabel *lblFirstTitle;
@property (strong, nonatomic) IBOutlet VMaskTextField *txtFieldFirst;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewFirst;
@property (strong, nonatomic) IBOutlet UILabel *lblSecondTitle;
@property (strong, nonatomic) IBOutlet VMaskTextField *txtFieldSecond;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewSecond;

#pragma mark - Cell Unique Checkbox
@property (strong, nonatomic) IBOutlet UILabel *lblFirstTitleUniqueCheckbox;
@property (strong, nonatomic) IBOutlet VMaskTextField *txtFieldFirstUniqueCheckbox;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewFirstUniqueCheckbox;
@property (strong, nonatomic) IBOutlet UILabel *lblSecondTitleUniqueCheckbox;
@property (strong, nonatomic) IBOutlet UIView *viewUniqueCheckbox;
@property (strong, nonatomic) IBOutlet UILabel *lblValueUniqueCheckbox;

#pragma mark - Cell Photo
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UIImageView *imgPhotoSelection;
@property (strong, nonatomic) IBOutlet UIButton *btnPhoto;




@end

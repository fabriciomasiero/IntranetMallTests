//
//  AFIMNewServiceOrderDetailCellTableViewCell.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFIMNewServiceOrderDetailCellTableViewCell : UITableViewCell

//CELLSHOPPINGINFO
@property (strong, nonatomic) IBOutlet UILabel *lblCellShoppingInfoShoppingName;
@property (strong, nonatomic) IBOutlet UILabel *lblCellShoppingInfoShopkeeperPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellShoppingInfoPhonePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellShoppingInfoEmailPlaceholder;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldCellShoppingInfoShopkeeper;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldCellShoppingInfoPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldCellShoppingInfoEmail;

//CELLSERVICE
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceServicePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceService;

//CELLDATE
@property (strong, nonatomic) IBOutlet UILabel *lblCellDateDateTitlePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellDateInitialPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellDateFinalPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellDateDatePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellDateHourPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellDateInitialDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCellDateInitialHour;
@property (strong, nonatomic) IBOutlet UILabel *lblCellDateFinalDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCellDateFinalHour;

//CELLDESCRIPTION
@property (strong, nonatomic) IBOutlet UILabel *lblCelLDescriptionDescriptionPlaceholder;
@property (strong, nonatomic) IBOutlet UITextView *txtViewCellDescriptionDescription;

//CELLADD
@property (strong, nonatomic) IBOutlet UIView *viewCellAddUser;
@property (strong, nonatomic) IBOutlet UILabel *lblCellAddAddUserPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellAddUserCount;

@property (strong, nonatomic) IBOutlet UIView *viewCellAddFile;
@property (strong, nonatomic) IBOutlet UILabel *lblCellAddAddFile;
@property (strong, nonatomic) IBOutlet UILabel *lblCellAddFileCount;

//CELLREQUESTER
@property (strong, nonatomic) IBOutlet UILabel *lblCellRequesterRequesterPlaceholder;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldCellRequesterRequester;

//CELLREQUESTERDESTINATION
@property (strong, nonatomic) IBOutlet UILabel *lblCellRequesterDestinationRequesterDestinationPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellRequesterDestinationUserType;
@property (strong, nonatomic) IBOutlet UIView *viewCellRequesterDestinationUserType;

@property (strong, nonatomic) IBOutlet UIView *viewCellRequesterDestinationBackgroundFirstItem;
@property (strong, nonatomic) IBOutlet UIView *viewCellRequesterDestinationWhiteBackgroundFirstItem;
@property (strong, nonatomic) IBOutlet UIView *viewCellRequesterDestinationContentFirstItem;
@property (strong, nonatomic) IBOutlet UILabel *lblCellRequesterDestinationFirstItemTitle;

@property (strong, nonatomic) IBOutlet UIView *viewCellRequesterDestinationBackgroundSecondItem;
@property (strong, nonatomic) IBOutlet UIView *viewCellRequesterDestinationWhiteBackgroundSecondItem;
@property (strong, nonatomic) IBOutlet UIView *viewCellRequesterDestinationContentSecondItem;
@property (strong, nonatomic) IBOutlet UILabel *lblCellRequesterDestinationSecondItemTitle;





@end

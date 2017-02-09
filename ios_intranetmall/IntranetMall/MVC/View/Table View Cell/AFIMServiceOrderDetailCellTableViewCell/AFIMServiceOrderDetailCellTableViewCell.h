//
//  AFIMServiceOrderDetailCellTableViewCell.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 05/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFIMServiceOrderDetailCellTableViewCell : UITableViewCell


//CELLNAME
@property (strong, nonatomic) IBOutlet UILabel *lblCellNameStoreName;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNameDatePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNameDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNameShopkeeperNamePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNameShopkeeperName;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNamePhonePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNamePhone;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNameRequesterPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNameRequester;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNameHourPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellNameHour;
@property (strong, nonatomic) IBOutlet UIView *viewCellName;

//CELLSERVICE
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceServicePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceServiceName;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceInitialPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceFinalPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceDatePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceHourPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceInitialDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceFinalDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceInitialHour;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceFinalHour;
@property (strong, nonatomic) IBOutlet UIView *viewCellService;

//CELLSERVICEDETAIL
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceDetailPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblCellServiceDetailInfo;
@property (strong, nonatomic) IBOutlet UIView *viewCellServiceDetail;

//CELLAUTHORIZEDUSERSHEADER
@property (strong, nonatomic) IBOutlet UILabel *lblCellAuthorizedUserHeaderTitle;

//CELLAUTHORIZEDUSERS
@property (strong, nonatomic) IBOutlet UILabel *lblAuthorizedUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblAuthorizedUserNameEnterprise;
@property (strong, nonatomic) IBOutlet UILabel *lblAuthorizedUserDocumentInsideCountry;

//CELLFILES
@property (strong, nonatomic) IBOutlet UILabel *lblCellFilesAttachedArchives;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewAttachedArchives;
@property (strong, nonatomic) IBOutlet UIView *viewCellFiles;

//CELLAPPROVERS
@property (strong, nonatomic) IBOutlet UILabel *lblCellApproversResponsible;
@property (strong, nonatomic) IBOutlet UILabel *lblCellApproversStatus;
@property (strong, nonatomic) IBOutlet UIView *viewCellApproversTypes;
@property (strong, nonatomic) IBOutlet UIView *viewCellApproversYes;
@property (strong, nonatomic) IBOutlet UILabel *lblCellApproversYes;
@property (strong, nonatomic) IBOutlet UIView *viewCellApproversNo;
@property (strong, nonatomic) IBOutlet UILabel *lblCellApproversNo;


@property (strong, nonatomic) IBOutlet UIView *viewCellApproversYesMiddleView;
@property (strong, nonatomic) IBOutlet UIView *viewCellApproversYesStatus;


@property (strong, nonatomic) IBOutlet UIView *viewCellApproversNoStatus;
@property (strong, nonatomic) IBOutlet UIView *viewCellApproversNoMiddleView;





@property (strong, nonatomic) IBOutlet UIView *viewCellFooter;

//CELLOBSERVATIONS
@property (strong, nonatomic) IBOutlet UIView *viewCellObservationsStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblCellObservationsDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCellObservationsName;
@property (strong, nonatomic) IBOutlet UILabel *lblCellObservationsObservation;

//CELLOBSERVATIONSTEXT
@property (strong, nonatomic) IBOutlet UITextView *txtViewCellObservationText;
@property (strong, nonatomic) IBOutlet UIButton *btnCellObservationText;



@end

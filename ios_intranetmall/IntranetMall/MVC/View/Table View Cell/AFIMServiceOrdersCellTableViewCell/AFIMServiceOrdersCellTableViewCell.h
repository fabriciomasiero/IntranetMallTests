//
//  AFIMServiceOrdersCellTableViewCell.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface AFIMServiceOrdersCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblServiceOrderNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblDatePlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblServiceOrderType;
@property (strong, nonatomic) IBOutlet UILabel *lblRequesterPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblRequester;
@property (strong, nonatomic) IBOutlet UILabel *lblEmailPlaceholder;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblDescriptionPlaceholder;
@property (strong, nonatomic) IBOutlet UITextView *lblDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imgStatus;


@end

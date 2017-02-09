//
//  AFIMNewServiceOrderDetailCellTableViewCell.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMNewServiceOrderDetailCellTableViewCell.h"
#import "CALayer+Extras.h"

@implementation AFIMNewServiceOrderDetailCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_viewCellRequesterDestinationWhiteBackgroundFirstItem.layer setCornerCircle];
    [_viewCellRequesterDestinationWhiteBackgroundSecondItem.layer setCornerCircle];
    [_viewCellRequesterDestinationContentFirstItem.layer setCornerCircle];
    [_viewCellRequesterDestinationContentSecondItem.layer setCornerCircle];
    [_viewCellRequesterDestinationBackgroundFirstItem.layer setCornerCircle];
    [_viewCellRequesterDestinationBackgroundSecondItem.layer setCornerCircle];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

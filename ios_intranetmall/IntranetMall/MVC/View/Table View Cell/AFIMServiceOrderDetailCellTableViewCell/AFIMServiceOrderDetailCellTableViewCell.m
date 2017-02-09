//
//  AFIMServiceOrderDetailCellTableViewCell.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 05/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderDetailCellTableViewCell.h"
#import "CALayer+Extras.h"
#import <HexColors/HexColors.h>

@implementation AFIMServiceOrderDetailCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_viewCellName.layer addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:.5f];
    [_viewCellService.layer addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:.5f];
    [_viewCellServiceDetail.layer addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:.5f];
    
    
    [_viewCellApproversYesStatus.layer setCornerCircle];
    [_viewCellApproversYes.layer setCornerCircle];
    [_viewCellApproversYesMiddleView.layer setCornerCircle];
    
    [_viewCellApproversNo.layer setCornerCircle];
    [_viewCellApproversNoStatus.layer setCornerCircle];
    [_viewCellApproversNoMiddleView.layer setCornerCircle];
    
//    [_viewCellName setNeedsLayout];
//    [_viewCellName layoutIfNeeded];
//    [_viewCellName layoutSubviews];
//    [_viewCellService setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

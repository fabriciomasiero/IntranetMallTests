//
//  AFIMNewServiceOrderCellTableViewCell.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMNewServiceOrderCellTableViewCell.h"

@implementation AFIMNewServiceOrderCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_viewCellBorder.layer setCornerCircle];
    [_viewCellWhiteBorder.layer setCornerCircle];
    [_viewBorderContent.layer setCornerCircle];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

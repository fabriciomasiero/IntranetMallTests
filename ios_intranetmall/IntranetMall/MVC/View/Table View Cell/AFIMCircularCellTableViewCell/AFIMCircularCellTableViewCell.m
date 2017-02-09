//
//  AFIMCircularCellTableViewCell.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMCircularCellTableViewCell.h"
#import "CALayer+Extras.h"

@implementation AFIMCircularCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_viewCircular.layer setCornerCircle];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AFIMAuthorizedUsersCellTableViewCell.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 12/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMAuthorizedUsersCellTableViewCell.h"
#import "CALayer+Extras.h"

@implementation AFIMAuthorizedUsersCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_viewSelectUser.layer setCornerCircle];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

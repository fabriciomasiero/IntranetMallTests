//
//  AFIMOfficialsCellTableViewCell.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMOfficialsCellTableViewCell.h"
#import "CALayer+Extras.h"

@implementation AFIMOfficialsCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_imgOfficial.layer setCornerCircle];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  AFIMOfficialEditCellTableViewCell.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 15/12/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMOfficialEditCellTableViewCell.h"
#import "CALayer+Extras.h"

@implementation AFIMOfficialEditCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [_viewTxtBackUnique.layer addBottomBorderWithColor:[UIColor darkGrayColor] andWidth:1.5f];
//    [_txtFieldUnique setBackgroundColor:[UIColor clearColor]];
//    
//    [_txtFieldUnique.layer addBottomBorderWithColor:[UIColor darkGrayColor] andWidth:.5f];
//    [_txtFieldFirst.layer addBottomBorderWithColor:[UIColor darkGrayColor] andWidth:.5f];
//    [_txtFieldSecond.layer addBottomBorderWithColor:[UIColor darkGrayColor] andWidth:.5f];
    [_imgPhoto.layer setCornerCircle];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

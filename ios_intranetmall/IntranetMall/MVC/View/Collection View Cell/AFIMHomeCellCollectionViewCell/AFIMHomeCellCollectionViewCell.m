//
//  AFIMHomeCellCollectionViewCell.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 25/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMHomeCellCollectionViewCell.h"

@implementation AFIMHomeCellCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [_viewLeft setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.5f]];
//    [_viewRight setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.5f]];
    
    [_viewLeftButton setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.5f]];
    [_viewRightButton setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:.5f]];

    
    
}

@end

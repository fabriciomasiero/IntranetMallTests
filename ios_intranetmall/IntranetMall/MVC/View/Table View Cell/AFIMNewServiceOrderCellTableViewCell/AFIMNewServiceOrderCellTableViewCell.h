//
//  AFIMNewServiceOrderCellTableViewCell.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALayer+Extras.h"

@interface AFIMNewServiceOrderCellTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *imgHeaderInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblHeaderInfo;


@property (strong, nonatomic) IBOutlet UIView *viewCellBorder;
@property (strong, nonatomic) IBOutlet UIView *viewCellWhiteBorder;
@property (strong, nonatomic) IBOutlet UIView *viewBorderContent;
@property (strong, nonatomic) IBOutlet UILabel *lblCellInfo;


@end

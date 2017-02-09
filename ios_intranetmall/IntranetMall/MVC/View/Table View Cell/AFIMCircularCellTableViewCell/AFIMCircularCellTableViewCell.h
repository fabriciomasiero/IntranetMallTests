//
//  AFIMCircularCellTableViewCell.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFIMCircularCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblCircularName;
@property (strong, nonatomic) IBOutlet UILabel *lblCircularDate;
@property (strong, nonatomic) IBOutlet UIView *viewCircular;
@property (strong, nonatomic) IBOutlet UILabel *lblCircularFirstChar;


@end

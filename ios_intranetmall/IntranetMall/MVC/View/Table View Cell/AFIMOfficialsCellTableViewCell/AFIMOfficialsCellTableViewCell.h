//
//  AFIMOfficialsCellTableViewCell.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 29/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFIMOfficialsCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgOfficial;

@property (strong, nonatomic) IBOutlet UILabel *lblOfficialName;
@property (strong, nonatomic) IBOutlet UILabel *lblOfficialRegisterDate;
@property (strong, nonatomic) IBOutlet UILabel *lblOfficialBirthDate;
@property (strong, nonatomic) IBOutlet UILabel *lblOfficialDocument;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;



@end

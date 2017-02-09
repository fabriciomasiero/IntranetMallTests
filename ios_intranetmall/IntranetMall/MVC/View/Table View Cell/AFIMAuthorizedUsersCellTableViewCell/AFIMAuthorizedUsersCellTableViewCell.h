//
//  AFIMAuthorizedUsersCellTableViewCell.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 12/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFIMAuthorizedUsersCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblUserDocumentInsideCountry;
@property (strong, nonatomic) IBOutlet UILabel *lblUserEnterprise;

@property (strong, nonatomic) IBOutlet UIView *viewSelectUser;


@end

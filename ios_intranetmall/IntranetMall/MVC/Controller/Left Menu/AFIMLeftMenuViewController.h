//
//  AFIMLeftMenuViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 23/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import <AFPlatform/AFPlatform.h>
#import "AFIMLeftMenuCellTableViewCell.h"

@interface AFIMLeftMenuViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSArray *infos;
@property (strong, nonatomic) IBOutlet UIImageView *imgShopping;


@property (strong, nonatomic) IBOutlet UITableView *tblView;


@end

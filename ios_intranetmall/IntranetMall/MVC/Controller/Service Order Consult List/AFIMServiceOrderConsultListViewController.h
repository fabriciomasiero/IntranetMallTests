//
//  AFIMServiceOrderConsultListViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 03/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMServiceOrdersCellTableViewCell.h"

@interface AFIMServiceOrderConsultListViewController : AFBaseViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) NSArray *serviceOrdersList;

@property (strong, nonatomic) IBOutlet UITableView *tblView;

@end

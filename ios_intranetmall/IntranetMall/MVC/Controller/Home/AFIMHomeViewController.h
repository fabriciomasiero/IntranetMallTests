//
//  AFIMHomeViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 25/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import <AFPlatform/AFPlatform.h>
#import "AFIMHomeCellCollectionViewCell.h"
#import "AFIMServiceOrderListViewController.h"
#import "AFIMUser.h"

@interface AFIMHomeViewController : AFBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>


@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) NSTimer *timer;

@property (nonatomic) int page;


@property (strong, nonatomic) NSArray *infos;

@property (strong, nonatomic) IBOutlet UICollectionView *cltView;

@property (strong, nonatomic) AFIMUser *user;

@end

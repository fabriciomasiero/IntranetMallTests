//
//  AFIMHomeCellCollectionViewCell.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 25/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFIMHomeCellCollectionViewCell : UICollectionViewCell

//CellCarrousel
@property (strong, nonatomic) IBOutlet UIScrollView *carrouselScrollView;
@property (strong, nonatomic) IBOutlet UIButton *btnCarrouselLeft;
@property (strong, nonatomic) IBOutlet UIButton *btnCarrouselRight;
@property (strong, nonatomic) IBOutlet UIView *viewLeft;
@property (strong, nonatomic) IBOutlet UIView *viewRight;
@property (strong, nonatomic) IBOutlet UIView *viewLeftButton;
@property (strong, nonatomic) IBOutlet UIView *viewRightButton;


//CellServiceOrder
@property (strong, nonatomic) IBOutlet UIImageView *imgServiceOrder;
@property (strong, nonatomic) IBOutlet UILabel *lblServiceOrder;
@property (strong, nonatomic) IBOutlet UIButton *btnWaitingApproval;
@property (strong, nonatomic) IBOutlet UIButton *btnNotAuthorized;
@property (strong, nonatomic) IBOutlet UIButton *btnAuthorized;
@property (strong, nonatomic) IBOutlet UIButton *btnInExecution;


//Cell
@property (strong, nonatomic) IBOutlet UIImageView *imgType;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblTypeCount;
@property (strong, nonatomic) IBOutlet UIView *viewType;


@end

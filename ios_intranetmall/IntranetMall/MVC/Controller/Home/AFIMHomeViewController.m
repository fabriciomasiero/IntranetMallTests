//
//  AFIMHomeViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 25/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMHomeViewController.h"
#import "AFIMLinkViewController.h"

@interface AFIMHomeViewController ()

@end

@implementation AFIMHomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicMenuInitialization:@"homeView"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [self getUserWithCompletion:^(AFIMUser *user) {
        self.user = user;
        [_cltView setDelegate:self];
        [_cltView setDataSource:self];
        [_cltView reloadData];
    }];
}

#pragma mark - Collection View Delegate & Datasource
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath; {
    return YES;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"CellCarrousel";
        AFIMHomeCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        [self configureScrollPageViewContents:cell.carrouselScrollView withPage:nil withArray:_user.carrousels];
        [cell.btnCarrouselLeft addTarget:self action:@selector(showPreviousImage:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnCarrouselRight addTarget:self action:@selector(showNextImage:) forControlEvents:UIControlEventTouchUpInside];
        
        if (!_timer) {
            [self configureTimer];
        }
        return cell;
        
    } else if (indexPath.row == 1) {
        
        static NSString *CellIdentifier = @"CellServiceOrder";
        AFIMHomeCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSString *waitingApproval = [NSString stringWithFormat:@"Aguardando Aprovação: %@", _user.home.waitingApproval];
        NSString *authorized = [NSString stringWithFormat:@"Autorizado: %@", _user.home.authorization];
        NSString *notAuthorized = [NSString stringWithFormat:@"Não Autorizado: %@", _user.home.notAuthorized];
        NSString *inExecution = [NSString stringWithFormat:@"Em Execução: %@", _user.home.running];
        
        
        [cell.btnWaitingApproval setTitle:waitingApproval forState:UIControlStateNormal];
        [cell.btnWaitingApproval addTarget:self action:@selector(waitingApprovalList:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnAuthorized setTitle:authorized forState:UIControlStateNormal];
        [cell.btnAuthorized addTarget:self action:@selector(authorizedList:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnNotAuthorized setTitle:notAuthorized forState:UIControlStateNormal];
        [cell.btnNotAuthorized addTarget:self action:@selector(notAuthorizedList:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnInExecution setTitle:inExecution forState:UIControlStateNormal];
        [cell.btnInExecution addTarget:self action:@selector(inExecutionList:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    
    } else {
        static NSString *CellIdentifier = @"Cell";
        AFIMHomeCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (indexPath.row == 2) {
            [cell.lblType setText:@"CIRCULAR"];
            [cell.imgType setImage:[UIImage imageNamed:@"imgCircularMenu"]];
            [cell.lblTypeCount setText:[NSString stringWithFormat:@"%@", _user.home.notReadCircular]];
            [cell.viewType setBackgroundColor:[UIColor colorWithHexString:@"FD7F27"]];
        } else {
            [cell.lblType setText:@"FUNCIONÁRIO"];
            [cell.imgType setImage:[UIImage imageNamed:@"imgUserWhite"]];
            if (![_user isAdmin]) {
                [cell.lblTypeCount setText:[NSString stringWithFormat:@"%@", _user.home.officialsCount]];
            } else {
                [cell.lblTypeCount setText:@""];
            }
            [cell.viewType setBackgroundColor:[UIColor colorWithHexString:@"e81d63"]];
        }
        return cell;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"showServicesOrders" sender:nil];
    } else if (indexPath.row == 2) {
//        [self pushDynamicSegue:@"circularListView"];
        [self performSegueWithIdentifier:@"showCircular" sender:nil];
//        [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"circularListView"]];
    } else if (indexPath.row == 3) {
//        [self pushDynamicSegue:@"officialListView"];
        [self performSegueWithIdentifier:@"showOfficials" sender:nil];
//        [self.sidePanelController setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"officialListView"]];
    }
    

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    256 134 114
    float width = 0.f;
    float height = 0.f;
    if (indexPath.row == 0) {
        width = ([UIScreen mainScreen].bounds.size.width * 320.f)/320.f;
        
        height = (([UIScreen mainScreen].bounds.size.height - 64.f) * 256)/504;
//        height = 256.f;
        
    } else if (indexPath.row == 1) {
        width = ([UIScreen mainScreen].bounds.size.width * 320.f)/320.f;
//        height = ([UIScreen mainScreen].bounds.size.width * 120.f)/320.f;
        height = (([UIScreen mainScreen].bounds.size.height - 64.f) * 134.f)/504;
//        height = 134.f;
    } else {
        width = ([UIScreen mainScreen].bounds.size.width * 160.f)/320.f;
        height = (([UIScreen mainScreen].bounds.size.height - 64.f) * 114.f)/504;
    }
    return CGSizeMake(width, height);
}


#pragma mark - ScrollView
#pragma mark - ScrollView Actions
- (void)configureScrollPageViewContents:(UIScrollView *)scrollView withPage:(UIPageControl *)pageControl withArray:(NSArray *)imagesScrolled {
    
    if ([imagesScrolled count] > 0) {
        [scrollView setBackgroundColor:[UIColor whiteColor]];
    } else {
        for(UIView *subviews in [scrollView subviews]) {
            [subviews removeFromSuperview];
        }
        [scrollView setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    [pageControl setNumberOfPages:[imagesScrolled count]];
    
    float width = self.view.frame.size.width;
    
    float height = (([UIScreen mainScreen].bounds.size.height - 64.f) * 256)/504;
    
    
    for (int i = 0; i < imagesScrolled.count; i++) {
        CGRect frame;
        frame.origin.x = width * i;
        frame.origin.y = 0;
        frame.size = scrollView.frame.size;

        UIImageView *subview = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, 0.f, width, height)];
        AFIMUserCarrousel *carrousel = imagesScrolled[i];
        [subview setContentMode:UIViewContentModeScaleToFill];
        [subview sd_setImageWithURL:carrousel.pictureUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        [subview setTag:i];
        [subview setUserInteractionEnabled:YES];
        [subview addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageInfo:)]];
        
        
        [scrollView addSubview:subview];
    }
    [scrollView setShowsHorizontalScrollIndicator:NO];
    scrollView.contentSize = CGSizeMake(width * imagesScrolled.count, height);
    _scrollView = scrollView;
    _pageControl = pageControl;
}

#pragma mark - ScrollView Animation & Layout Basics
- (void)changeStatePageAndScroll {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    
    [UIView animateWithDuration:.25 animations:^{
        [_pageControl setCurrentPage:_page];
        [_scrollView setContentOffset:CGPointMake(pageWidth * [self getNextPage], 0)];
    }];
    
}

- (void)showPreviousImage:(UIButton *)sender {
    [_timer invalidate];
    CGFloat pageWidth = self.scrollView.frame.size.width;
    [UIView animateWithDuration:.25 animations:^{
        [_pageControl setCurrentPage:_page];
        [_scrollView setContentOffset:CGPointMake(pageWidth * [self getNextPage], 0)];
    }];
    
}
- (void)showNextImage:(UIButton *)sender {
    [_timer invalidate];
    CGFloat pageWidth = self.scrollView.frame.size.width;
    [UIView animateWithDuration:.25 animations:^{
        [_pageControl setCurrentPage:_page];
        [_scrollView setContentOffset:CGPointMake(pageWidth * [self getNextPage], 0)];
        [self configureTimer];
    }];
}

- (int)getNextPage {
    if (_page < [_user.carrousels count]) {
        _page++;
        if (_page == [_user.carrousels count]) {
            _page = 0;
        }
    } else {
        _page = 0;
    }
    return _page;
}
- (void)showImageInfo:(UITapGestureRecognizer *)sender {
    [_timer invalidate];
    [self configureTimer];
    AFIMUserCarrousel *carrousel = _user.carrousels[sender.view.tag];
    if (carrousel.link) {
        if (carrousel.link.length > 5) {
            NSLog(@"user carrousel :%@", carrousel.link);
            
            [self performSegueWithIdentifier:@"showLink" sender:carrousel];
        }
    }
    
}
- (void)configureTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(changeStatePageAndScroll) userInfo:nil repeats:YES];
}

#pragma mark - UIButton Actions & Gestures
- (void)waitingApprovalList:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showServicesOrders" sender:@(1)];
}

- (void)authorizedList:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showServicesOrders" sender:@(2)];
}

- (void)notAuthorizedList:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showServicesOrders" sender:@(3)];
}

- (void)inExecutionList:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showServicesOrders" sender:@(4)];
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showServicesOrders"]) {
        AFIMServiceOrderListViewController *lVc = [segue destinationViewController];
        if (sender) {
            NSNumber *number = (NSNumber *)sender;
            [lVc setTypeSelectedOnHome:[number integerValue]];
        }
    } else if ([[segue identifier] isEqualToString:@"showLink"]) {
        AFIMLinkViewController *lVc = [segue destinationViewController];
        [lVc setUserCarrousel:sender];
    }
}

@end

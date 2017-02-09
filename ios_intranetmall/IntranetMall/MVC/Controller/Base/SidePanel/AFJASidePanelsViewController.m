//
//  AFJASidePanelsViewController.m
//  PetIdealCliente
//
//  Created by Fabricio Masiero on 14/07/16.
//  Copyright © 2016 Fabricio Masiero(AppFactory). All rights reserved.
//

#import "AFJASidePanelsViewController.h"
#import "AFIMLeftMenuViewController.h"

CGFloat const kFixedWidht = 290.f;

@interface AFJASidePanelsViewController ()

@end

@implementation AFJASidePanelsViewController

@synthesize user;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    user = [AFUserSession shared].loggedUser;
    UINavigationController *nav;
    if (user) {
        nav = [self.storyboard instantiateViewControllerWithIdentifier:@"homeView"];
    } else {
        nav = [self.storyboard instantiateViewControllerWithIdentifier:@"homeView"];
    }
    
    
    
    self.centerPanel = nav;
    
    AFIMLeftMenuViewController *leftView = [self.storyboard instantiateViewControllerWithIdentifier:@"leftView"];
    self.leftPanel = leftView;
    
    self.leftFixedWidth = kFixedWidht;
    self.rightFixedWidth = kFixedWidht;
}

#pragma mark - Singleton

- (void)stylePanel:(UIView *)panel {
}



@end

//
//  AFLoginViewController.h
//  Alsco
//
//  Created by Ricardo Ramos on 1/27/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <AFPlatform/AFPlatform.h>

@protocol AFLoginViewControllerDelegate;
@class AFApplicationUser;

@interface AFLoginViewController : AFViewController

@property (weak, nonatomic) id<AFLoginViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *navigationBarCancelButton;

- (BOOL)shouldCreateViewAutomatically;
- (void)doLogin;
- (IBAction)sendButtonPressed;


@end

@protocol AFLoginViewControllerDelegate <NSObject>

- (void)loginViewController:(AFLoginViewController *)loginViewController didStartSessionWithUser:(AFApplicationUser *)user;
- (void)loginViewController:(AFLoginViewController *)loginViewController didFailWithError:(NSError *)error;

@end
//
//  AFRecoverPasswordViewController.h
//  AFPlatform
//
//  Created by Ricardo Ramos on 16/03/15.
//  Copyright (c) 2015 AppFactory. All rights reserved.
//

#import <AFPlatform/AFPlatform.h>

@protocol AFRecoverPasswordViewControllerDelegate;

@interface AFRecoverPasswordViewController : AFViewController

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) id<AFRecoverPasswordViewControllerDelegate> delegate;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)sendButtonPressed:(id)sender;

@end

@protocol AFRecoverPasswordViewControllerDelegate <NSObject>

@optional

- (void)recoverPasswordViewController:(AFRecoverPasswordViewController *)viewController didFinishWithMessage:(NSString *)message;
- (void)recoverPasswordViewController:(AFRecoverPasswordViewController *)viewController didFailWithError:(NSError *)error;

@end
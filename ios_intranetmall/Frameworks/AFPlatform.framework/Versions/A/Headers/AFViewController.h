//
//  AFViewController.h
//  Alsco
//
//  Created by Ricardo Ramos on 1/27/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import <AFPlatform/AFPlatform.h>

typedef NS_ENUM(NSInteger, AFLoadingViewType) {
    AFLoadingViewTypeDefault,
    AFLoadingViewTypeBlurred,
};

@class AFLoginViewController;

@interface AFViewController : UIViewController

@property (readonly, nonatomic) UIImageView *blurredImageView;
@property (readonly, nonatomic) UIView *loadingView;
@property (assign, nonatomic) AFLoadingViewType loadingViewType;
@property (assign, nonatomic) BOOL ignoresUserSession;
@property (assign, nonatomic) BOOL receiveKeyboardNotifications;
@property (assign, nonatomic) BOOL keyboardVisible;
@property (assign, nonatomic) BOOL shouldShowNavigationRefreshButton;

@property (assign, nonatomic) BOOL trackPageViewOnlyInViewDidLoad;

- (AFLoginViewController *)loginViewController;
- (void)presentLoginViewController;
- (void)showLoading:(BOOL)show;
- (void)showLoadingHUD:(BOOL)show;
- (void)showNavigationRefreshLoading:(BOOL)show;
- (void)refreshButtonPressed;
- (void)showErrorAlert:(NSError *)error;
- (void)showErrorAlert:(NSError *)error title:(NSString *)title;
- (void)showDefaultBackground;
- (void)keyboardWillShow;
- (void)keyboardWillHide;
- (void)keyboardDidShow;
- (void)keyboardDidHide;
- (void)userSessionDidStart;
- (UINavigationController *)nav;
- (void)applicationDidBecomeActive;
- (UIImage *)screenshot;
- (UIActivityIndicatorViewStyle)loadingIndicationViewStyle;

- (NSString *)trackPathForViewController;
- (NSString *)trackPageViewLabelForViewController;
- (NSString *)titleForTrackPageView;
- (void)trackPageView;
- (NSString *)clearStringForTrackString:(NSString *)string;

@end

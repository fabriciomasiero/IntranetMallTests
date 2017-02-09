//
//  AFIMLoginViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 22/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import <ASJDropDownMenu/ASJDropDownMenu.h>
#import "AFIMLogin.h"
#import "AFIMDigitalBadgeViewController.h"
#import <QRCodeReaderViewController/QRCodeReader.h>
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>

@interface AFIMLoginViewController : AFBaseViewController <UITextFieldDelegate, QRCodeReaderDelegate>

@property (strong, nonatomic) NSArray *shoppings;
@property (nonatomic) BOOL scanned;


@property (strong, nonatomic) ASJDropDownMenu *dropDownMenu;

#pragma mark - IBoutlets
@property (strong, nonatomic) IBOutlet UITextField *txtFieldShopping;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldPassword;
@property (strong, nonatomic) IBOutlet UIView *viewShopping;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnDigitalBadge;

- (IBAction)login:(UIButton *)sender;

- (IBAction)openDigitalBadge:(UIButton *)sender;

- (IBAction)scanQrCode:(UIButton *)sender;

@end

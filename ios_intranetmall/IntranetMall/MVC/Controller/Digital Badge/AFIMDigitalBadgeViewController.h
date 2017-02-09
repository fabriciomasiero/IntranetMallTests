//
//  AFIMDigitalBadgeViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 23/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMShoppings.h"
#import <ASJDropDownMenu/ASJDropDownMenu.h>
#import <VMaskTextField/VMaskTextField.h>
#import <ZRQRCodeViewController/ZRQRCodeViewController.h>
#import "NSData+Extras.h"
#import <RNCryptor-objc/RNCryptor.h>
#import <RNCryptor-objc/RNEncryptor.h>
#import <RNCryptor-objc/RNDecryptor.h>
#import "AFIMCrypt.h"

@interface AFIMDigitalBadgeViewController : AFBaseViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSArray *shoppings;

@property (strong, nonatomic) AFIMShoppings *selectedShopping;


@property (strong, nonatomic) ASJDropDownMenu *dropDownMenu;
@property (strong, nonatomic) UIButton *btnRemoveBadge;

@property (strong, nonatomic) IBOutlet UITextField *txtFieldShopping;
@property (strong, nonatomic) IBOutlet VMaskTextField *txtFieldDocument;
@property (strong, nonatomic) IBOutlet UIButton *btnGenerateBadge;

@property (strong, nonatomic) IBOutlet UIView *viewShopping;
@property (strong, nonatomic) IBOutlet UIView *viewDocument;
@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (strong, nonatomic) IBOutlet UIView *viewInfosBlock;
@property (strong, nonatomic) IBOutlet UIView *viewBadgeFinal;

- (IBAction)generateBadge:(UIButton *)sender;

@end

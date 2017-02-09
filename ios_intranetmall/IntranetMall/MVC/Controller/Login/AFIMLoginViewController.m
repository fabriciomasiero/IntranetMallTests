//
//  AFIMLoginViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 22/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMLoginViewController.h"
#import "AFIMShoppings.h"
#import "AFIMUser.h"


@interface AFIMLoginViewController ()

@end

@implementation AFIMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self callShoppings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self configureTextFields];
    [self configureButton];
    
}
- (void)configureTextFields {
    [_txtFieldShopping setDelegate:self];
    [_txtFieldUsername setDelegate:self];
    [_txtFieldPassword setDelegate:self];
}
- (void)configureButton {
//    0092ee
    [_btnLogin.layer setCornerRadius:10.f];
    [_btnLogin.layer setMasksToBounds:YES];
    [_btnLogin.layer setBorderWidth:1.f];
    [_btnLogin.layer setBorderColor:[UIColor colorWithHexString:@"0092ee"].CGColor];
    [_btnDigitalBadge.layer setBorderWidth:1.f];
    [_btnDigitalBadge.layer setBorderColor:[UIColor colorWithHexString:@"0092ee"].CGColor];
}

- (void)callShoppings {
    [AFIMShoppings getShoppingsWithCompletion:^(NSArray *shoppings) {
        _shoppings = shoppings;
        _dropDownMenu = [[ASJDropDownMenu alloc] initWithView:_viewShopping menuItems:@[]];
        [_dropDownMenu setHidesOnSelection:YES];
    } failure:^(NSError *error) {
        
    }];
}
- (void)organizeShoppings:(NSString *)text {
    if (text.length > 2) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", text];
        NSMutableArray *shops = [[_shoppings filteredArrayUsingPredicate:predicate] mutableCopy];
        if ([shops count] > 0) {
            NSMutableArray *mutableItens = [[NSMutableArray alloc] init];
            for (AFIMShoppings *s in shops) {
                [mutableItens addObject:[ASJDropDownMenuItem itemWithTitle:s.name]];
            }
            [_dropDownMenu setMenuItems:[mutableItens mutableCopy]];
            
            [self showDropDown];
        } else {
//            [_dropDownMenu setMenuItems:nil];
            [self hideDropDown];
        }
    } else {
        [self hideDropDown];
    }
}

- (void)showDropDown {
    
    [_dropDownMenu showMenuWithCompletion:^(ASJDropDownMenu * _Nonnull dropDownMenu, ASJDropDownMenuItem * _Nonnull menuItem, NSUInteger index) {
        [_txtFieldShopping setText:menuItem.title];
        [_txtFieldShopping resignFirstResponder];
        [self hideDropDown];
    }];
    [self.view bringSubviewToFront:_dropDownMenu];
}
- (void)hideDropDown {
    [_dropDownMenu hideMenu];
}

- (void)prepareToLogin {
    if (_txtFieldShopping.text.length < 5) {
        [self showDefaultAlertView:@"Atenção" andMessage:@"O shopping não está correto!" completionAction:^(NSString *action) {
            
        }];
        return;
    }
    if (_txtFieldUsername.text.length < 2) {
        [self showDefaultAlertView:@"Atenção" andMessage:@"Parece que o usuário informado não existe!" completionAction:^(NSString *action) {
            
        }];
        return;
    }
    if (_txtFieldPassword.text.length < 2) {
        [self showDefaultAlertView:@"Atenção" andMessage:@"Confira a senha digitada!" completionAction:^(NSString *action) {
            
        }];
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", _txtFieldShopping.text];
    NSMutableArray *shop = [[_shoppings filteredArrayUsingPredicate:predicate] mutableCopy];
    if ([shop count] > 0) {
        AFIMShoppings *s = [shop firstObject];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [AFIMLogin loginWithUserName:_txtFieldUsername.text password:_txtFieldPassword.text shopping:s andCompletion:^(AFIMUser *user) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self saveUserInstance:user];
            [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"sidePanel"] animated:YES completion:nil];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self showDefaultAlertView:@"Atenção" andMessage:error.localizedDescription completionAction:^(NSString *action) {
                
            }];
        }];
    }
}


#pragma mark - UIButtons Actions 
- (IBAction)login:(UIButton *)sender {
    [_txtFieldShopping resignFirstResponder];
    [_txtFieldUsername resignFirstResponder];
    [_txtFieldPassword resignFirstResponder];
    [self prepareToLogin];
}

- (IBAction)openDigitalBadge:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showBadge" sender:nil];
}

- (IBAction)scanQrCode:(UIButton *)sender {
    
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    QRCodeReaderViewController *qrCodeVc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancelar" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    
    // Set the presentation style
    qrCodeVc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [qrCodeVc setDelegate:self];
    
    
    [self presentViewController:qrCodeVc animated:YES completion:NULL];
    
}


- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result {
    
    [reader dismissViewControllerAnimated:YES completion:nil];
    if (!_scanned) {
//        Models *model = [Models find:@"name == %@", result];
//        if (model) {
            _scanned = YES;
        
//            [self performSegueWithIdentifier:@"showTiresDetail" sender:model];
//        }
    }
    
}
- (void)readerDidCancel:(QRCodeReaderViewController *)reader {
    [reader dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _txtFieldShopping) {
        [self organizeShoppings:textField.text];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showBadge"]) {
        AFIMDigitalBadgeViewController *dBadgeVc = [segue destinationViewController];
        dBadgeVc.shoppings = _shoppings;
        
    }
}


@end

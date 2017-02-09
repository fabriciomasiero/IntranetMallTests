//
//  AFIMDigitalBadgeViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 23/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMDigitalBadgeViewController.h"
#import "NSString+Extras.h"


NSString *const KEY = @"qrc0d3";

@interface AFIMDigitalBadgeViewController ()

@end

@implementation AFIMDigitalBadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self callShoppings];
    [self configureTextFields];
    [_viewDocument setHidden:YES];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [_txtFieldDocument setMask:@"###.###.###-##"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self configureButton];
    [self showBadgeIfNeccessary];
}

- (void)configureTextFields {
    [_txtFieldShopping setDelegate:self];
    [_txtFieldDocument setDelegate:self];
}
- (void)configureButton {
    [_btnGenerateBadge.layer setCornerRadius:10.f];
    [_btnGenerateBadge.layer setMasksToBounds:YES];
    [_btnGenerateBadge.layer setBorderWidth:1.f];
    [_btnGenerateBadge.layer setBorderColor:[UIColor colorWithHexString:@"0092ee"].CGColor];
}

- (void)validateDocument:(NSString *)document {
    if (document.length == 14) {
        if ([[document prepareToCheck] cpfIsValid]) {
            [UIView animateWithDuration:1.f animations:^{
                [_btnGenerateBadge setHidden:NO];
            }];
        } else {
            
            
            [self showDefaultAlertView:@"Atenção" andMessage:@"O CPF informado é inválido" completionAction:^(NSString *action) {
                [UIView animateWithDuration:1.f animations:^{
                    [_btnGenerateBadge setHidden:YES];
                }];
            }];
            
        }
    }
}
- (void)callShoppings {
    if (!_shoppings) {
        [AFIMShoppings getShoppingsWithCompletion:^(NSArray *shoppings) {
            _shoppings = shoppings;
            _dropDownMenu = [[ASJDropDownMenu alloc] initWithView:_viewShopping menuItems:@[]];
            [_dropDownMenu setHidesOnSelection:YES];
        } failure:^(NSError *error) {
            
        }];
    } else {
        _dropDownMenu = [[ASJDropDownMenu alloc] initWithView:_viewShopping menuItems:@[]];
        [_dropDownMenu setHidesOnSelection:YES];
    }
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
            [_dropDownMenu setMenuItems:@[]];
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
        [_viewDocument setHidden:NO];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", menuItem.title];
        NSArray *shopping = [_shoppings filteredArrayUsingPredicate:predicate];

        if ([shopping count] > 0) {
            _selectedShopping = (AFIMShoppings *)[shopping firstObject];
        }
    }];
    [self.view bringSubviewToFront:_dropDownMenu];
}
- (void)hideDropDown {
    [_dropDownMenu hideMenu];
}

#pragma mark - UITextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _txtFieldShopping) {
        [self organizeShoppings:textField.text];
    } else {
        VMaskTextField *vTextField = (VMaskTextField *)textField;
        NSString *doc = [textField.text stringByAppendingString:string];
        if ([string isEqualToString:@""]) {
            doc = [textField.text substringToIndex:[doc length]-1];
        }
        [self validateDocument:doc];
        return  [vTextField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (IBAction)generateBadge:(UIButton *)sender {
    
    [self prepareToGenerateQRCode];
    
    
}
- (void)prepareToGenerateQRCode {

    [self encryptString:_txtFieldDocument.text withKey:KEY];
}
- (void)encryptString:(NSString *)document withKey:(NSString *)key {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AFIMCrypt encryptWithDocument:document key:key andCompletion:^(NSString *encryptHash) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self generateQRCodeWithHash:encryptHash];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showDefaultAlertView:@"Atenção" andMessage:error.localizedDescription completionAction:^(NSString *action) {
            
        }];
    }];
}



- (void)generateQRCodeWithHash:(NSString *)hash {
    
    
    [[NSUserDefaults standardUserDefaults] setObject:hash forKey:@"badgeHash"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:_selectedShopping.shoppingId forKey:@"shoppingId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self showBadgeIfNeccessary];
}

- (void)showBadgeIfNeccessary {
    
    [_txtFieldDocument resignFirstResponder];
    [_txtFieldShopping resignFirstResponder];
    [self.view endEditing:YES];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"badgeHash"]) {
        [UIView animateWithDuration:.5f animations:^{
            [_viewHeader setHidden:YES];
            [_viewInfosBlock setHidden:YES];
            [_viewBadgeFinal setHidden:NO];
        }];
        float widht = 10.f;
        CGRect rect = CGRectMake(widht, 40.f, [UIScreen mainScreen].bounds.size.width - widht * 2, [UIScreen mainScreen].bounds.size.width - widht * 2);
        
        UIView *viewBadge = [[UIView alloc] initWithFrame:rect];
        [viewBadge setBackgroundColor:[UIColor whiteColor]];
        NSNumber *shoppingId = [[NSUserDefaults standardUserDefaults] objectForKey:@"shoppingId"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"shoppingId == %@", shoppingId];
        NSArray *shopping = [_shoppings filteredArrayUsingPredicate:predicate];
        if ([shopping count] > 0) {
            _selectedShopping = (AFIMShoppings *)[shopping firstObject];
        }
        
        UIImageView *imgShopping = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 20.f, viewBadge.frame.size.width, 60.f)];
        [imgShopping setContentMode:UIViewContentModeScaleAspectFit];
        [imgShopping sd_setImageWithURL:_selectedShopping.pictureUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
//        [imgShopping setBackgroundColor:[UIColor redColor]];
        
        [viewBadge addSubview:imgShopping];
        
        CGRect rectBadge = CGRectMake(30.f, 90.f, viewBadge.frame.size.width - 60.f, viewBadge.frame.size.height - 120.f);
        UIImageView *myBadge = [[[ZRQRCodeViewController alloc] init] generateQuickResponseCodeWithFrame:rectBadge dataString:[[NSUserDefaults standardUserDefaults] objectForKey:@"badgeHash"]];
        [myBadge setContentMode:UIViewContentModeScaleAspectFit];
        [viewBadge addSubview:myBadge];
        
        [_viewBadgeFinal addSubview:viewBadge];
        
        if (!_btnRemoveBadge) {
            _btnRemoveBadge = [[UIButton alloc] init];
        }
        [_btnRemoveBadge setFrame:CGRectMake(widht, rect.origin.y + rect.size.height + 8.f, [UIScreen mainScreen].bounds.size.width - widht * 2, 40.f)];
        [_btnRemoveBadge setTitle:@"Remover Crachá" forState:UIControlStateNormal];
        [_btnRemoveBadge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnRemoveBadge.layer setBorderColor:[UIColor colorWithHexString:@"0092ee"].CGColor];
        [_btnRemoveBadge.layer setBorderWidth:1.f];
        [_btnRemoveBadge.layer setCornerRadius:10.f];
        [_btnRemoveBadge.layer setMasksToBounds:YES];
        [_btnRemoveBadge addTarget:self action:@selector(removeBadge:) forControlEvents:UIControlEventTouchUpInside];
        [_viewBadgeFinal addSubview:_btnRemoveBadge];
        
    } else {
        [self showInfos];
    }
    
}
- (void)showInfos {
    [UIView animateWithDuration:.5f animations:^{
        [_viewHeader setHidden:NO];
        [_viewInfosBlock setHidden:NO];
        [_viewBadgeFinal setHidden:YES];
    }];
}


- (void)removeBadge:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"badgeHash"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shoppingId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self showBadgeIfNeccessary];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

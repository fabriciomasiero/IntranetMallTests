//
//  AFIMNewAuthorizedUserViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 12/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMNewAuthorizedUserViewController.h"

@interface AFIMNewAuthorizedUserViewController ()

@end

@implementation AFIMNewAuthorizedUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_txtFieldDocumentInsideCountry setMask:@"##.###.###-#"];
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [_txtFieldName setDelegate:self];
    [_txtFieldDocumentInsideCountry setDelegate:self];
    [_txtFieldEnterprise setDelegate:self];
}


#pragma mark - UIButton Actions
- (IBAction)saveUser:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (_txtFieldName.text.length < 3) {
        return;
    }
    if (_txtFieldDocumentInsideCountry.text.length < 3) {
        return;
    }
    if (_txtFieldEnterprise.text.length < 3) {
        return;
    }
    
    ServiceOrderAuthorizedUser *user = [[AFDatabaseManager sharedManager] createAuthorizedUser:_txtFieldName.text documentInsideCountry:_txtFieldDocumentInsideCountry.text enterprise:_txtFieldEnterprise.text];
    if (user) {
        AFIMNewServiceOrderAuthorizedUsers *newUserModel = [[AFIMNewServiceOrderAuthorizedUsers alloc] initWithUser:user andSelected:YES];
        [_createdUserDelegate authorizedUserCreated:newUserModel];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self showDefaultAlertView:@"Atenção" andMessage:@"Erro ao inserir usuário!" completionAction:^(NSString *action) {
            
        }];
    }
    
}

#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    VMaskTextField *vTextField = (VMaskTextField *)textField;
    
    if (_txtFieldName.text.length > 2) {
        if (_txtFieldDocumentInsideCountry.text.length > 2) {
            if (_txtFieldEnterprise.text.length > 2) {
                [_btnSave setTotallyEnabled:YES];
                if (vTextField.mask.length > 0) {
                    return [vTextField shouldChangeCharactersInRange:range replacementString:string];
                } else {
                    return YES;
                }
            }
        }
    }
    [_btnSave setTotallyEnabled:NO];
    if (vTextField.mask.length > 0) {
        return [vTextField shouldChangeCharactersInRange:range replacementString:string];
    } else {
        return YES;
    }
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

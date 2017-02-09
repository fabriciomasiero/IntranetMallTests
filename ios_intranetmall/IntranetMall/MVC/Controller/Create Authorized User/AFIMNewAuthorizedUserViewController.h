//
//  AFIMNewAuthorizedUserViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 12/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFDatabaseManager.h"
#import "AFIMNewServiceOrderAuthorizedUsers.h"
#import <VMaskTextField/VMaskTextField.h>

@protocol AFIMNewServicerOrderAuthorizedUserCreatedDelegate

@optional
- (void)authorizedUserCreated:(AFIMNewServiceOrderAuthorizedUsers *)createdUser;

@end

@interface AFIMNewAuthorizedUserViewController : AFBaseViewController <UITextFieldDelegate>

@property (assign, nonatomic) id <AFIMNewServicerOrderAuthorizedUserCreatedDelegate> createdUserDelegate;




@property (strong, nonatomic) IBOutlet VMaskTextField *txtFieldName;
@property (strong, nonatomic) IBOutlet VMaskTextField *txtFieldDocumentInsideCountry;
@property (strong, nonatomic) IBOutlet VMaskTextField *txtFieldEnterprise;

@property (strong, nonatomic) IBOutlet UIButton *btnSave;

- (IBAction)saveUser:(UIButton *)sender;

@end

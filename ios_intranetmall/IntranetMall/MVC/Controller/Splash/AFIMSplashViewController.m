//
//  AFIMSplashViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFIMSplashViewController.h"

@interface AFIMSplashViewController ()

@end

@implementation AFIMSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(checkIfUserLogged) userInfo:nil repeats:NO];
    
}
- (void)checkIfUserLogged {
    NSDictionary *dic = [AFIMLogin userInfos];
    if (dic) {
        AFIMShoppings *shopping = [[AFIMShoppings alloc] initWithDictionary:dic];
        [AFIMLogin loginWithUserName:dic[@"login"] password:dic[@"password"] shopping:shopping andCompletion:^(AFIMUser *user) {
            [self saveUserInstance:user];
            [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"sidePanel"] animated:YES completion:nil];
        } failure:^(NSError *error) {
            [self performSegueWithIdentifier:@"showLogin" sender:dic];
        }];
    } else {
        [self performSegueWithIdentifier:@"showLogin" sender:nil];
    }
    
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end

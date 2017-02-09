//
//  AFIMCircularViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMCircularViewController.h"

@interface AFIMCircularViewController ()

@end

@implementation AFIMCircularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:_circular.title];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (_circular) {
        NSURL *targetURL = [NSURL URLWithString:_circular.archiveName];
        NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        [_webView setDelegate:self];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_webView loadRequest:request];
        [self getUserWithCompletion:^(AFIMUser *user) {
            [AFIMCircular readCircular:@(_circular.circularId) user:user andCompletion:^(BOOL read) {
                if (read) {
                    [_circular setRead:YES];
                    [_circular save];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }];
        
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showDefaultAlertView:@"Atenção" andMessage:@"Ocorreu um erro desconhecido, tente novamente mais tarde" completionAction:^(NSString *action) {
            
        }];
    }
}

#pragma mark - UIWebView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {


}

@end

//
//  AFIMLinkViewController.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMLinkViewController.h"

@interface AFIMLinkViewController ()

@end

@implementation AFIMLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSString *fileUrl = @"";
    if (_userCarrousel) {
        fileUrl = _userCarrousel.link;
    } else {
        fileUrl = _fileUrl;
    }
    NSURL *targetURL = [NSURL URLWithString:fileUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [_webView setDelegate:self];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [_webView loadRequest:request];

}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

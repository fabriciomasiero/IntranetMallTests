//
//  MGSocialViewController.h
//  RadioMegaFM
//
//  Created by Ricardo Ramos on 2/2/14.
//  Copyright (c) 2014 AppFactory. All rights reserved.
//

#import "AFViewController.h"

@interface AFWebViewController : AFViewController

@property (strong, nonatomic) NSURL *contentURL;
@property (readonly, nonatomic) UIWebView *webView;

@end

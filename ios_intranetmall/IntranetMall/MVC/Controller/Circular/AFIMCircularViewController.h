//
//  AFIMCircularViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 13/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMCircular.h"

@interface AFIMCircularViewController : AFBaseViewController <UIWebViewDelegate>


@property (strong, nonatomic) Circular *circular;

@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end

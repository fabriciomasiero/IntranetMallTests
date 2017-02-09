//
//  AFIMLinkViewController.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 24/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBaseViewController.h"
#import "AFIMUserCarrousel.h"

@interface AFIMLinkViewController : AFBaseViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) AFIMUserCarrousel *userCarrousel;
@property (strong, nonatomic) NSString *fileUrl;

@end

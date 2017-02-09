//
//  UIButton+Extras.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 12/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "UIButton+Extras.h"

@implementation UIButton (Extras)

- (void)setTotallyEnabled:(BOOL)b {
    [UIView animateWithDuration:.2f animations:^{
        [self setEnabled:b];
        [self setAlpha:[self getAlphaLookingEnabled:b]];
    }];
    
}
- (CGFloat)getAlphaLookingEnabled:(BOOL)b {
    if (b) {
        return 1.f;
    }
    return .5f;
}


@end

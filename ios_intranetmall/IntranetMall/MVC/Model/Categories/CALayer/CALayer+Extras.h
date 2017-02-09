//
//  CALayer+Extras.h
//  PirelliAgro
//
//  Created by Fabricio Masiero on 05/08/16.
//  Copyright © 2016 Fabricio Masiero(AppFactory). All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Extras)


- (void)setCornerRadius:(CGFloat)rad andMaskToBounds:(BOOL)mask;

- (void)setCornerCircle;

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth;

- (void)addAllBorderWithColor:(UIColor *)color andWidht:(CGFloat)borderWidth;




@end

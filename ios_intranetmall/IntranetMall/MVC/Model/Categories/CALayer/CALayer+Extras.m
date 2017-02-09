//
//  CALayer+Extras.m
//  PirelliAgro
//
//  Created by Fabricio Masiero on 05/08/16.
//  Copyright © 2016 Fabricio Masiero(AppFactory). All rights reserved.
//

#import "CALayer+Extras.h"

@implementation CALayer (Extras)


- (void)setCornerRadius:(CGFloat)rad andMaskToBounds:(BOOL)mask {
    [self setCornerRadius:rad];
    [self setMasksToBounds:mask];
}
- (void)setCornerCircle {
    [self setCornerRadius:self.frame.size.width / 2.f];
    [self setMasksToBounds:YES];
}

- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    
    [self addSublayer:border];
}

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self addSublayer:border];
}

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self addSublayer:border];
}

- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self addSublayer:border];
}

- (void)addAllBorderWithColor:(UIColor *)color andWidht:(CGFloat)borderWidth {
    [self setBorderColor:color.CGColor];
    [self setBorderWidth:borderWidth];
}



@end

//
//  UIImage+Extras.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 04/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extras)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (UIImage *)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float)i_width;

@end

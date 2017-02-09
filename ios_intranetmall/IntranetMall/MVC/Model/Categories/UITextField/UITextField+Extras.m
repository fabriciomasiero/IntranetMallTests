//
//  UITextField+Extras.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 15/12/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "UITextField+Extras.h"
#import <objc/runtime.h>

@implementation UITextField (Extras)

- (NSInteger)section {
    id resp = objc_getAssociatedObject(self, @selector(section));
    NSInteger integ = (NSInteger)resp;
    return integ;
//    self.section = section;
}

@end

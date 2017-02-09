//
//  AFIMServiceOrderConsult.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderConsult.h"

@implementation AFIMServiceOrderConsult

- (BOOL)canConsult {
    if ((self.date) && (self.hour) && ([self.servicesStatus count] > 0) && ([self.services count] > 0)) {
        return YES;
    }
    return NO;
}

@end

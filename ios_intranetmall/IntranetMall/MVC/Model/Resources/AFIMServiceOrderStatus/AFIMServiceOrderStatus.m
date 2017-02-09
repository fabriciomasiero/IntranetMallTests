//
//  AFIMServiceOrderStatus.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 02/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderStatus.h"

@implementation AFIMServiceOrderStatus

- (id)initWithTitle:(NSString *)title statusId:(NSInteger)statusId {
    if (self) {
        _title = title;
        _statusId = statusId;
    }
    return self;
}

@end

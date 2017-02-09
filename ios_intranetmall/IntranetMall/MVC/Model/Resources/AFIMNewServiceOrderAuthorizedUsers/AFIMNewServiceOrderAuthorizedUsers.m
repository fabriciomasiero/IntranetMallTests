//
//  AFIMNewServiceOrderAuthorizedUsers.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 12/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMNewServiceOrderAuthorizedUsers.h"

@implementation AFIMNewServiceOrderAuthorizedUsers


- (id)initWithUser:(ServiceOrderAuthorizedUser *)user andSelected:(BOOL)selected {
    if (self) {
        _user = user;
        _selected = selected;
    }
    return self;
}
@end

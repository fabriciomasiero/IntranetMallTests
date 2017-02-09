//
//  AFIMListOrderGroups.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMListOrderGroups.h"

@implementation AFIMListOrderGroups

- (id)initWithValue:(id)value andSelectionState:(BOOL)selected isTypeKindHeader:(BOOL)header withServices:(NSArray *)services {
    if (self) {
        _value = value;
        _selected = selected;
        _header = header;
        _services = services;
    }
    return self;
}

- (NSString *)description {
    
    NSString *info = [NSString stringWithFormat:@"Value = %@ \n"
                      "Selected = %d  \n"
                      "Header = %d  \n"
                      "Selected = %@  \n", self.value, self.selected, self.header, self.services];
    return info;
}

@end

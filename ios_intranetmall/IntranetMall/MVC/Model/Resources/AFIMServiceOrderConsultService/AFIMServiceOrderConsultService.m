//
//  AFIMServiceOrderConsultService.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFIMServiceOrderConsultService.h"

@implementation AFIMServiceOrderConsultService

- (id)initWithValue:(id)value selectionState:(BOOL)selected {
    if (self) {
        _value = value;
        _selected = selected;
    }
    return self;
}


+ (NSArray *)insertServicesList:(NSArray *)serviceList {
    NSMutableArray *mutableValues = [[NSMutableArray alloc] init];
    NSMutableArray *mutableItem = [[NSMutableArray alloc] init];
    [mutableItem addObject:@"Todos"];
    [mutableItem addObjectsFromArray:serviceList];
    serviceList = [NSArray arrayWithArray:[mutableItem mutableCopy]];
    
    for (id service in serviceList) {
        [mutableValues addObject:[[AFIMServiceOrderConsultService alloc] initWithValue:service selectionState:NO]];
    }
    
    return [NSArray arrayWithArray:[mutableValues mutableCopy]];
}

@end

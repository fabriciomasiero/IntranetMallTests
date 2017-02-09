//
//  AFIMListOrderGroups.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 10/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFIMListOrderGroups : NSObject

- (id)initWithValue:(id)value andSelectionState:(BOOL)selected isTypeKindHeader:(BOOL)header withServices:(NSArray *)services;

@property (nonatomic) BOOL selected;
@property (strong, nonatomic) id value;
@property (nonatomic) BOOL header;
@property (strong, nonatomic) NSArray *services;

@end

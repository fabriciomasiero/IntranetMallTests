//
//  AFIMServiceOrderConsultService.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 01/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFIMServiceOrderConsultService : NSObject



@property (strong, nonatomic) id value;
@property (nonatomic) BOOL selected;




- (id)initWithValue:(id)value selectionState:(BOOL)selected;




+ (NSArray *)insertServicesList:(NSArray *)serviceList;

@end

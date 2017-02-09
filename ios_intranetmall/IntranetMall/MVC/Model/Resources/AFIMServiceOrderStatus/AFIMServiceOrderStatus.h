//
//  AFIMServiceOrderStatus.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 02/02/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFIMServiceOrderStatus : NSObject

- (id)initWithTitle:(NSString *)title statusId:(NSInteger)statusId;

@property (nonatomic) NSInteger statusId;
@property (strong, nonatomic) NSString *title;

@end

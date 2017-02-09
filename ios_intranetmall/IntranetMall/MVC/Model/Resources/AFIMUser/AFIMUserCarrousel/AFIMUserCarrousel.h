//
//  AFIMUserCarrousel.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 23/11/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFPlatform/AFPlatform.h>
#import "NSDictionary+Extras.h"

@interface AFIMUserCarrousel : AFDictionaryModel

@property (strong, nonatomic) NSNumber *imageId;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSNumber *order;
@property (strong, nonatomic) NSNumber *imageType;
@property (strong, nonatomic) NSURL *pictureUrl;


@end

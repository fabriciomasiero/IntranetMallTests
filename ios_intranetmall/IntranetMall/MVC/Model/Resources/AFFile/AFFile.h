//
//  AFFile.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 11/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFFile : NSObject

- (id)initWithFile:(id)file fileExtension:(NSString *)fileExtension fileEncoded:(NSString *)fileEncoded fileName:(NSString *)fileName bytes:(NSInteger)bytes;

@property (strong, nonatomic) NSString *fileEncoded;
@property (strong, nonatomic) NSString *fileExtension;
@property (strong, nonatomic) id file;
@property (strong, nonatomic) NSString *fileName;
@property (nonatomic) NSInteger bytes;

@end

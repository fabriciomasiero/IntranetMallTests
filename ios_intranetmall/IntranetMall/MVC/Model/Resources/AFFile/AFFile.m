//
//  AFFile.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 11/01/17.
//  Copyright © 2017 Fabrício Masiero. All rights reserved.
//

#import "AFFile.h"

@implementation AFFile

- (id)initWithFile:(id)file fileExtension:(NSString *)fileExtension fileEncoded:(NSString *)fileEncoded fileName:(NSString *)fileName bytes:(NSInteger)bytes {
    if (self) {
        _file = file;
        _fileExtension = fileExtension;
        _fileEncoded = fileEncoded;
        _fileName = fileName;
        _bytes = bytes;
    }
    return self;
}

@end

//
//  AFXMLReader.h
//  RadioMegaFM
//
//  Created by Ricardo Ramos on 10/5/12.
//  Copyright (c) 2012 AppFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFXMLReader : NSObject <NSXMLParserDelegate> {
@private
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError * __autoreleasing *errorPointer;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLParser:(NSXMLParser *)parser error:(NSError **)errorPointer;



@end

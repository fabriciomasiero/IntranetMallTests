//
//  NSString+Extras.h
//  PetIdealCliente
//
//  Created by Fabricio Masiero on 18/07/16.
//  Copyright © 2016 Fabricio Masiero(AppFactory). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extras)

+ (NSString *)stringGetFullDate:(NSDate *)d;
+ (NSString *)stringGetDayDate:(NSDate *)d;
+ (NSString *)stringGetDayDateUsDate:(NSDate *)d;
+ (NSString *)stringGetHourDate:(NSDate *)d;
+ (NSString *)stringGetDateToShow:(NSDate *)d;
+ (NSString *)stringGetDateToShowMonth:(NSDate *)d;
+ (NSString *)stringGetDayDateToShow:(NSDate *)d;
+ (NSString *)stringGetHourDateToShow:(NSDate *)d;

- (BOOL)emailIsValid;
- (NSString *)prepareToCheck;
- (BOOL)cpfIsValid;
- (BOOL)nameIsValid;
- (BOOL)dateIsValid;
- (BOOL)zipCodeIsValid;



//- (NSDate *)convertStringInDate;

- (NSString *)isEmptyString;

- (NSString *)preparePhoneToCall;
- (NSString *)formatToDocumentIdentifier;
- (NSString *)formatToPhone;

+ (NSString *)getValueForItemForm:(NSString *)item;



@end

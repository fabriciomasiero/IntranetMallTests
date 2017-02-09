//
//  NSString+Extras.m
//  PetIdealCliente
//
//  Created by Fabricio Masiero on 18/07/16.
//  Copyright © 2016 Fabricio Masiero(AppFactory). All rights reserved.
//

#import "NSString+Extras.h"

@implementation NSString (Extras)

#pragma mark - Method Class
+ (NSString *)stringGetFullDate:(NSDate *)d {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *stringDate = [[dateFormatter stringFromDate:d] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    return stringDate;
}
+ (NSString *)stringGetDayDate:(NSDate *)d {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringDate = [[dateFormatter stringFromDate:d] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    if (!stringDate) {
        stringDate = @"";
    }
    return stringDate;
}
+ (NSString *)stringGetDayDateUsDate:(NSDate *)d {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringDate = [[dateFormatter stringFromDate:d] stringByReplacingOccurrencesOfString:@"" withString:@""];
    
    if (!stringDate) {
        stringDate = @"";
    }
    return stringDate;
}
+ (NSString *)stringGetHourDate:(NSDate *)d {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *stringDate = [[dateFormatter stringFromDate:d] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    return stringDate;
}
+ (NSString *)stringGetDateToShow:(NSDate *)d {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *stringDate = [[dateFormatter stringFromDate:d] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    
    stringDate = [stringDate stringByReplacingOccurrencesOfString:@" " withString:@" às "];
    
    
    return stringDate;
}
+ (NSString *)stringGetDateToShowMonth:(NSDate *)d {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMM HH:mm"];
    NSString *stringDate = [[dateFormatter stringFromDate:d] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    
    stringDate = [stringDate stringByReplacingOccurrencesOfString:@" " withString:@" às "];
    
    
    return stringDate;
}


+ (NSString *)stringGetDayDateToShow:(NSDate *)d {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *stringDate = [[dateFormatter stringFromDate:d] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    
    stringDate = [stringDate stringByReplacingOccurrencesOfString:@" " withString:@" às "];
    
    
    return stringDate;
}
+ (NSString *)stringGetHourDateToShow:(NSDate *)d {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *stringDate = [[dateFormatter stringFromDate:d] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    
    stringDate = [stringDate stringByReplacingOccurrencesOfString:@" " withString:@" às "];
    
    
    return stringDate;
}



#pragma mark - Instance Class
- (NSString *)prepareToCheck {
    NSString *str = self;
    str = [str stringByReplacingOccurrencesOfString:@"." withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"," withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"@" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
    return str;
}

- (BOOL)emailIsValid {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; //  return 0;
    return [emailTest evaluateWithObject:self];
}
- (BOOL)cpfIsValid {
    NSUInteger i, firstSum, secondSum, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck;
    if(self == nil) return NO;
    
    if ([self length] != 11) return NO;
    if (([self isEqual:@"00000000000"]) || ([self isEqual:@"11111111111"]) || ([self isEqual:@"22222222222"])|| ([self isEqual:@"33333333333"])|| ([self isEqual:@"44444444444"])|| ([self isEqual:@"55555555555"])|| ([self isEqual:@"66666666666"])|| ([self isEqual:@"77777777777"])|| ([self isEqual:@"88888888888"])|| ([self isEqual:@"99999999999"])) return NO;
    
    firstSum = 0;
    for (i = 0; i <= 8; i++) {
        firstSum += [[self substringWithRange:NSMakeRange(i, 1)] intValue] * (10 - i);
    }
    
    if (firstSum % 11 < 2)
        firstDigit = 0;
    else
        firstDigit = 11 - (firstSum % 11);
    
    secondSum = 0;
    for (i = 0; i <= 9; i++) {
        secondSum = secondSum + [[self substringWithRange:NSMakeRange(i, 1)] intValue] * (11 - i);
    }
    
    if (secondSum % 11 < 2)
        secondDigit = 0;
    else
        secondDigit = 11 - (secondSum % 11);
    
    firstDigitCheck = [[self substringWithRange:NSMakeRange(9, 1)] intValue];
    secondDigitCheck = [[self substringWithRange:NSMakeRange(10, 1)] intValue];
    
    if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck))
        return YES;
    return NO;
}

- (BOOL)nameIsValid {
    NSString *str = self;
    if (str.length > 3) {
        return YES;
    }
    return NO;
}
- (BOOL)dateIsValid {
    NSString *str = self;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    
    dateFromString = [dateFormatter dateFromString:str];
    
    if (dateFromString) {
        return YES;
    }
    return NO;
}

- (BOOL)zipCodeIsValid {
    NSString *str = self;
    
    if (str.length > 6 && str.length <= 9) {
        return YES;
    }
    return NO;
}


- (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *stringDate = [dateFormatter stringFromDate:[NSDate date]];
    return stringDate;
}

- (NSString *)isEmptyString {
    if (!self) {
        return @"";
    }
    if ([self isEqualToString:@"<null>"]) {
        return @"";
    }
    return self;
}

- (NSString *)preparePhoneToCall {
    NSString *phone = [[self stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return phone;
}
- (NSString *)formatToDocumentIdentifier {
    if (self.length == 11) {
        NSString *myDocument = [self prepareToCheck];
        NSScanner *scan = [NSScanner scannerWithString:myDocument];
        int val;
        if ([scan scanInt:&val] && [scan isAtEnd]) {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setGroupingSeparator:@"."];
            [formatter setGroupingSize:2];
            [formatter setUsesGroupingSeparator:YES];
            [formatter setSecondaryGroupingSize:3];
            
            
            NSString *str = [formatter stringFromNumber:[NSNumber numberWithDouble:[myDocument doubleValue]]];
            
            NSString *documentPrefix = [str substringToIndex:[str length] - 3];
            NSString *lastComponent = [str substringFromIndex:[str length] - 3];
            lastComponent = [lastComponent stringByReplacingOccurrencesOfString:@"." withString:@"-"];
            
            
            NSString *documentIdentifier = [NSString stringWithFormat:@"%@%@", documentPrefix, lastComponent];
            
            
            return documentIdentifier;
        } else {
            return self;
        }
    }
    return self;
}
- (NSString *)formatToPhone {
    if (self.length == 13 || self.length == 14) {
        NSString *myPhone = self;
        NSScanner *scan = [NSScanner scannerWithString:[myPhone prepareToCheck]];
        int val;
        if ([scan scanInt:&val] && [scan isAtEnd]) {
            myPhone = [myPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            if (myPhone.length == 12) {
                NSString *phonePrefix = [myPhone substringToIndex:[myPhone length] - 4];
                NSString *lastComponent = [myPhone substringFromIndex:[myPhone length] - 4];
                
                NSString *phone = [NSString stringWithFormat:@"%@-%@", phonePrefix, lastComponent];
                return phone;
                
            } else {
                NSString *phonePrefix = [myPhone substringToIndex:[myPhone length] - 4];
                NSString *lastComponent = [myPhone substringFromIndex:[myPhone length] - 4];
                
                NSString *phone = [NSString stringWithFormat:@"%@-%@", phonePrefix, lastComponent];
                return phone;
            }
        }
        return self;
    }
    return self;
}

+ (NSString *)getValueForItemForm:(NSString *)item {
    
    if ([item isEqualToString:@"CPF"]) {
        return @"documentIdentifier";
    } else if ([item isEqualToString:@"Nome"]) {
        return @"shopkeeperName";
    } else if ([item isEqualToString:@"Número do RG"]) {
        return @"documentInsideCountry";
    } else if ([item isEqualToString:@"Data Nascimento"]) {
        return @"birthDate";
    } else if ([item isEqualToString:@"Naturalidade"]) {
        return @"naturalness";
    } else if ([item isEqualToString:@"Sexo"]) {
        return @"sexuality";
    } else if ([item isEqualToString:@"Nome da mãe"]) {
        return @"momFiliation";
    } else if ([item isEqualToString:@"Nome do pai"]) {
        return @"dadFilitation";
    } else if ([item isEqualToString:@"Cargo"]) {
        return @"officialRole";
    } else if ([item isEqualToString:@"Telefone"]) {
        return @"phone";
    } else if ([item isEqualToString:@"Data Admissão"]) {
        return @"registerDate";
    } else if ([item isEqualToString:@"Data Demissão"]) {
        return @"resignationDate";
    } else if ([item isEqualToString:@"CEP"]) {
        return @"postalCode";
    } else if ([item isEqualToString:@"Endereço"]) {
        return @"address";
    } else if ([item isEqualToString:@"Número"]) {
        return @"number";
    } else if ([item isEqualToString:@"Complemento"]) {
        return @"complement";
    } else if ([item isEqualToString:@"Bairro"]) {
        return @"neighborhood";
    } else if ([item isEqualToString:@"Município"]) {
        return @"city";
    } else if ([item isEqualToString:@"UF"]) {
        return @"state";
    } else {
        return @"";
    }
}

@end

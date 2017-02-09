//
//  AFForm.h
//  IntranetMall
//
//  Created by Fabrício Masiero on 15/12/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum AFFormType : NSInteger {
    kAFFormTypeUnique,
    kAFFormTypeDual,
    kAFFormTypeUniqueCheckbox
} AFFormType;

typedef enum AFFormTypeValidation : NSInteger {
    kAFFormTypeValidationDocumentIdentifier,
    kAFFormTypeValidationZipCode,
    kAFFormTypeValidationGeneralName,
    kAFFormTypeValidationDates
} AFFormTypeValidation;

@interface AFForm : NSObject

- (id)initWithTitle:(id)titles values:(id)values images:(id)images isDual:(BOOL)dual formMask:(id)mask type:(AFFormType)formType cellType:(NSString *)cellType needsAValidation:(id)needsAValidation formTypeValidation:(id)formTypeValidation;


@property (strong, nonatomic) id titles;
@property (strong, nonatomic) id values;
@property (strong, nonatomic) id images;
@property (nonatomic) BOOL dual;
@property (strong, nonatomic) id mask;
@property (nonatomic) AFFormType formType;
@property (strong, nonatomic) NSString *cellType;
@property (strong, nonatomic) id needsAValidation;
@property (nonatomic) id formTypeValidation;

@end

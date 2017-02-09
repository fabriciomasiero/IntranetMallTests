//
//  AFForm.m
//  IntranetMall
//
//  Created by Fabrício Masiero on 15/12/16.
//  Copyright © 2016 Fabrício Masiero. All rights reserved.
//

#import "AFForm.h"

@implementation AFForm



- (id)initWithTitle:(id)titles values:(id)values images:(id)images isDual:(BOOL)dual formMask:(id)mask type:(AFFormType)formType cellType:(NSString *)cellType needsAValidation:(id)needsAValidation formTypeValidation:(id)formTypeValidation {
    if (self) {
        _titles = titles;
        _values = values;
        _images = images;
        _dual = dual;
        _mask = mask;
        _formType = formType;
        _cellType = cellType;
        _needsAValidation = needsAValidation;
        _formTypeValidation = formTypeValidation;
    }
    return self;
}

- (NSString *)description {
    
    NSString *info = [NSString stringWithFormat:@"Titles = %@ \n"
                      "Values = %@  \n"
                      "Images = %@  \n"
                      "Dual = %@  \n"
                      "Mask = %@ \n"
                      "Form Type = %li \n"
                      "Cell Type = %@", self.titles, self.values, self.images, @(self.dual), self.mask, (long)self.formType, self.cellType];
    return info;
}

@end

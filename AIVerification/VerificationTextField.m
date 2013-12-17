//
//  VerificationTextField.m
//  Pods
//
//  Created by Brian Thomas on 12/13/13.
//
//

#import "VerificationTextField.h"

@implementation VerificationTextField

- (UITextField *)objectForKeyedSubscript:(id)key
{
    id fieldForReturn = self.tester[key];
    return (UITextField *)fieldForReturn;
}

@end

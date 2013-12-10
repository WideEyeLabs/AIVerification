//
//  UITextField+Verify.m
//  iVerifyExample
//
//  Created by Brian Thomas on 9/25/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import <objc/runtime.h>
#import "UITextField+Verify.h"
#import "VerificationTest.h"

#define kEmailRegEXP @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

static char verifyDelegateKey;

@implementation UITextField (Verify)

- (void)setVerifyDelegate:(VerificationTest *)delegate
{
    objc_setAssociatedObject(self, &verifyDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN);
}

- (VerificationTest *)verifyDelegate
{
    return (VerificationTest *)objc_getAssociatedObject(self, &verifyDelegateKey);
}

- (void)removeVerifyDelegate
{
    objc_removeAssociatedObjects(self);
}


#pragma mark -- Simple API

- (void)verifyItIsNotEmpty
{
    VerificationTest *verifier = [self verifyDelegate];
    [self verifyItIsNotEmptyWithError:[NSString stringWithFormat:@"The %@ field must not be empty.",
                                       [verifier stringRepresentationForVerifyField:self]]];
}

- (void)verifyItIsLongerThan:(NSNumber *)length
{
    VerificationTest *verifier = [self verifyDelegate];
    [self verifyItIsLongerThan:length withError:[NSString stringWithFormat:@"The %@ field must be longer than %u characters.",
                                                 [verifier stringRepresentationForVerifyField:self], length.intValue]];
}

- (void)verifyItIsANumber
{
    VerificationTest *verifier = [self verifyDelegate];
    [self verifyItIsANumberWithError:[NSString stringWithFormat:@"The %@ field must be a number.",
                                      [verifier stringRepresentationForVerifyField:self]]];
}

- (void)verifyItMatches:(NSString *)stringToMatch withDescription:(NSString *)desc
{
    VerificationTest *verifier = [self verifyDelegate];
    [self verifyItMatches:stringToMatch withError:[NSString stringWithFormat:@"The %@ field must match the %@.",
                                                   [verifier stringRepresentationForVerifyField:self], desc]];
}

- (void)verifyItIsAnEmailAddress
{
    VerificationTest *verifier = [self verifyDelegate];
    [self verifyItIsAnEmailAddressWithError:[NSString stringWithFormat:@"The %@ field must be a valid email address",
                                    [verifier stringRepresentationForVerifyField:self]]];
}


#pragma mark -- Block API

- (void)verifyItIsNotEmptyWithError:(NSString *)error
{
    VerificationTest *verifier = [self verifyDelegate];
    if ([self.text isEqualToString:@""])
    {
        [verifier verificationFailedWithError:error];
    }
    [self removeVerifyDelegate];
}

- (void)verifyItIsLongerThan:(NSNumber *)length withError:(NSString *)error
{
    VerificationTest *verifier = [self verifyDelegate];
    if (self.text.length < length.intValue)
    {
        [verifier verificationFailedWithError:error];
    }
    [self removeVerifyDelegate];
}

- (void)verifyItIsANumberWithError:(NSString *)error
{
    VerificationTest *verifier = [self verifyDelegate];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *myNumber = [formatter numberFromString:self.text];
    if (myNumber == nil)
    {
        [verifier verificationFailedWithError:error];
    }
    [self removeVerifyDelegate];
}

- (void)verifyItMatches:(NSString *)stringToMatch withError:(NSString *)error
{
    VerificationTest *verifier = [self verifyDelegate];
    if (![self.text isEqualToString:stringToMatch])
    {
        [verifier verificationFailedWithError:error];
    }
    [self removeVerifyDelegate];
}

- (void)verifyItIsAnEmailAddressWithError:(NSString *)error
{
    VerificationTest *verifier = [self verifyDelegate];
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:kEmailRegEXP options:0 error:nil];
    NSArray *matches = [expression matchesInString:self.text options:0 range:NSMakeRange(0, self.text.length)];
    if (!(matches.count == 1))
    {
        [verifier verificationFailedWithError:error];
    }
    [self removeVerifyDelegate];
}

@end

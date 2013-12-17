//
//  UITextField+Verify.h
//  iVerifyExample
//
//  Created by Brian Thomas on 9/25/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VerificationTest;

@interface UITextField (Verify)

// Default Error Messages
- (void)verifyItIsNotEmpty;
- (void)verifyItIsLongerThan:(NSNumber *)length;
- (void)verifyItIsANumber;
- (void)verifyItMatches:(NSString *)stringToMatch withDescription:(NSString *)desc;
- (void)verifyItIsAnEmailAddress;

// Custom Error Messages
- (void)verifyItIsNotEmptyWithError:(NSString *)error;
- (void)verifyItIsLongerThan:(NSNumber *)length withError:(NSString *)error;
- (void)verifyItIsANumberWithError:(NSString *)error;
- (void)verifyItMatches:(NSString *)stringToMatch withError:(NSString *)error;
- (void)verifyItIsAnEmailAddressWithError:(NSString *)error;

@end

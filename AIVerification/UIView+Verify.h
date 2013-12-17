//
//  UIView+Verify.h
//  Pods
//
//  Created by Brian Thomas on 12/16/13.
//
//

#import <UIKit/UIKit.h>

@class VerificationTest;

@interface UIView (Verify)

- (void)setVerifyDelegate:(VerificationTest *)delegate;
- (VerificationTest *)verifyDelegate;
- (void)removeVerifyDelegate;

@end

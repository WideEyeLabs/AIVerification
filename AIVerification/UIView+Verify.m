//
//  UIView+Verify.m
//  Pods
//
//  Created by Brian Thomas on 12/16/13.
//
//

#import <objc/runtime.h>
#import "UIView+Verify.h"

static char verifyDelegateKey;

@implementation UIView (Verify)

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

@end

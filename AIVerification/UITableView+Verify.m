//
//  UITableView+Verify.m
//  
//
//  Created by Brian Thomas on 9/25/13.
//
//

#import <objc/runtime.h>
#import "VerificationTest.h"
#import "UITableView+Verify.h"

static char verifyDelegateKey;

@implementation UITableView (Verify)

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

- (void)verifyARowIsSelected
{
    VerificationTest *verifier = [self verifyDelegate];
    if (!self.indexPathForSelectedRow)
    {
        [verifier verificationFailedWithError:
         [NSString stringWithFormat:@"You must select a %@.",
          [verifier stringRepresentationForVerifyField:self]]];
    }
}

@end

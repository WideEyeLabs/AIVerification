//
//  UITableView+Verify.m
//  
//
//  Created by Brian Thomas on 9/25/13.
//
//

#import <objc/runtime.h>
#import "UIView+Verify.h"
#import "VerificationTest.h"
#import "UITableView+Verify.h"

@implementation UITableView (Verify)

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

//
//  UITableView+Verify.h
//  
//
//  Created by Brian Thomas on 9/25/13.
//
//

#import <UIKit/UIKit.h>

@class VerificationTest;

@interface UITableView (Verify)

- (void)setVerifyDelegate:(VerificationTest *)delegate;
- (void)removeVerifyDelegate;

- (void)verifyARowIsSelected;

@end

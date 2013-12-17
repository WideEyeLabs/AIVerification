//
//  VerificationUIVIew.m
//  Pods
//
//  Created by Brian Thomas on 12/16/13.
//
//

#import "VerificationUIView.h"

@implementation VerificationUIView

- (instancetype)initWithTest:(VerificationTest *)test
{
    self = [super init];
    if (self) {
        self.tester = test;
    }
    return self;
}

@end

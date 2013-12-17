//
//  VerificationUIVIew.h
//  Pods
//
//  Created by Brian Thomas on 12/16/13.
//
//

#import <Foundation/Foundation.h>
#import "VerificationTest.h"

@interface VerificationUIView : NSObject

@property (weak, nonatomic) VerificationTest *tester;

- (instancetype)initWithTest:(id)test;

@end

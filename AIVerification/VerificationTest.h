//
//  Verify.h
//  iVerifyExample
//
//  Created by Brian Thomas on 9/25/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VerificationTest : NSObject

@property (strong, nonatomic) NSDictionary *inputsToVerify;
@property (strong, nonatomic) NSMutableArray *errors;

+ (NSArray *)forInputs:(NSDictionary *)inputs andTestCases:(void(^)(VerificationTest *inspect))inspections;

- (id)textField;
- (id)tableView;
- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (NSString *)stringRepresentationForVerifyField:(id)field;
- (void)verificationFailedWithError:(NSString *)error;

@end

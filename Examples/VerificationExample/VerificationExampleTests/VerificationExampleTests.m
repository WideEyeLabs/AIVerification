//
//  VerificationExampleTests.m
//  VerificationExampleTests
//
//  Created by Brian Thomas on 12/9/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AIVerification.h>

@interface VerificationExampleTests : XCTestCase

@property (strong, nonatomic) UITableView *unselectedTable;
@property (strong, nonatomic) UITextField *emptyField;
@property (strong, nonatomic) UITextField *numberField;
@property (strong, nonatomic) UITextField *fiveCharField;
@property (strong, nonatomic) NSDictionary *inputFields;

@end

@implementation VerificationExampleTests

- (void)setUp
{
    [super setUp];
    
    _emptyField = [[UITextField alloc] init];
    
    _numberField = [[UITextField alloc] init];
    [_numberField setText:@"23"];
    
    _fiveCharField = [[UITextField alloc] init];
    [_fiveCharField setText:@"5char"];
    
    _unselectedTable = [[UITableView alloc] init];
    
    _inputFields = @{@"empty": _emptyField, @"5char": _fiveCharField, @"number": _numberField};
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFieldNotEmptySuccess
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"5char"] verifyItIsNotEmpty];
    }];
    
    XCTAssertNotNil(errors, @"No array was returned.");
    XCTAssert([errors count] == 0, @"An error was incorrectly generated.");
}

- (void)testFieldNotEmptyFailure
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"empty"] verifyItIsNotEmpty];
    }];
    
    XCTAssertNotNil(errors, @"No array was returned.");
    XCTAssert([errors count] == 1, @"The inspection generated an incorrect amount of errors.");
    XCTAssert([@"The empty field must not be empty." isEqualToString:(NSString *)errors[0]], @"The error generated is not correct.");
}

- (void)testFieldLengthSuccess
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"5char"] verifyItIsLongerThan:@4];
    }];
    
    XCTAssertNotNil(errors, @"No array was returned.");
    XCTAssert([errors count] == 0, @"An error was incorrectly generated.");
}

- (void)testFieldLengthFailure
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"5char"] verifyItIsLongerThan:@6];
    }];
    
    XCTAssertNotNil(errors, @"No array was returned.");
    XCTAssert([errors count] == 1, @"The inspection generated an incorrect amount of errors.");
    XCTAssert([@"The 5char field must be longer than 6 characters." isEqualToString:(NSString *)errors[0]], @"The error generated is not correct.");
}

@end

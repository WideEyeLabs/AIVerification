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
@property (strong, nonatomic) UITextField *validEmailField;
@property (strong, nonatomic) UITextField *invalidEmailField;
@property (strong, nonatomic) UITextField *emptyField;
@property (strong, nonatomic) UITextField *numberField;
@property (strong, nonatomic) UITextField *fiveCharField;
@property (strong, nonatomic) NSDictionary *inputFields;

@end

#define kNoArrayErrorMessage @"No array was returned."
#define kWrongErrorMessage @"The error generated is not correct."
#define kErrorIncorrectlyGenerated @"An error was incorrectly generated."
#define kWrongNumberOFErrors @"The inspection generated an incorrect number of errors."

@implementation VerificationExampleTests

- (void)setUp
{
    [super setUp];
    
    _validEmailField = [[UITextField alloc] init];
    _validEmailField.text = @"valid_email@example.com";
    
    _invalidEmailField = [[UITextField alloc] init];
    _invalidEmailField.text = @"nope@be.c";
    
    _emptyField = [[UITextField alloc] init];
    
    _numberField = [[UITextField alloc] init];
    [_numberField setText:@"23"];
    
    _fiveCharField = [[UITextField alloc] init];
    [_fiveCharField setText:@"5char"];

    
    _unselectedTable = [[UITableView alloc] init];
    
    _inputFields = @{@"validEmail" : _validEmailField, @"invalidEmail" : _invalidEmailField, @"empty": _emptyField, @"5char": _fiveCharField, @"number": _numberField};
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

    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 0, kErrorIncorrectlyGenerated);
}

- (void)testFieldNotEmptyFailure
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"empty"] verifyItIsNotEmpty];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 1, kWrongNumberOFErrors);
    XCTAssert([@"The empty field must not be empty." isEqualToString:(NSString *)errors[0]], kWrongErrorMessage);
}

- (void)testFieldLengthSuccess
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"5char"] verifyItIsLongerThan:@4];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 0, kErrorIncorrectlyGenerated);
}

- (void)testFieldLengthFailure
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"5char"] verifyItIsLongerThan:@6];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 1, kWrongNumberOFErrors);
    XCTAssert([@"The 5char field must be longer than 6 characters." isEqualToString:(NSString *)errors[0]], kWrongErrorMessage);
}

- (void)testThatAValidEmailPassesVerification
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"validEmail"] verifyItIsAnEmailAddress];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 0, kErrorIncorrectlyGenerated);
}

- (void)testThatAnInvalidEmailFailsVerification
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"invalidEmail"] verifyItIsAnEmailAddress];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 1, kWrongNumberOFErrors);
    XCTAssert([@"The invalidEmail field must be a valid email address." isEqualToString:(NSString *)errors[0]], kWrongErrorMessage);
}

- (void)testThatMultipleVerificationsPreserveOrder
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"empty"] verifyItIsNotEmpty];
        [inspect[@"5char"] verifyItIsLongerThan:@6];
        [inspect[@"invalidEmail"] verifyItIsAnEmailAddress];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 3, kWrongNumberOFErrors);
    XCTAssert([@"The empty field must not be empty." isEqualToString:(NSString *)errors[0]], kWrongErrorMessage);
    XCTAssert([@"The 5char field must be longer than 6 characters." isEqualToString:(NSString *)errors[1]], kWrongErrorMessage);
    XCTAssert([@"The invalidEmail field must be a valid email address." isEqualToString:(NSString *)errors[2]], kWrongErrorMessage);
}
@end

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
@property (strong, nonatomic) UITextField *matchingFiveCharField;
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
    _invalidEmailField = [[UITextField alloc] init];
    _emptyField = [[UITextField alloc] init];
    _numberField = [[UITextField alloc] init];
    _fiveCharField = [[UITextField alloc] init];
    _matchingFiveCharField = [[UITextField alloc] init];
    
    _validEmailField.text = @"valid_email@example.com";
    _invalidEmailField.text = @"nope@be.c";
    _numberField.text = @"23";
    _fiveCharField.text = @"5char";
    _matchingFiveCharField.text = _fiveCharField.text;
    
    _unselectedTable = [[UITableView alloc] init];
    
    _inputFields = @{@"validEmail" : _validEmailField,
                     @"invalidEmail" : _invalidEmailField,
                     @"empty" : _emptyField,
                     @"5char" : _fiveCharField,
                     @"number" : _numberField,
                     @"matching" : _matchingFiveCharField};
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatANonEmptyFieldPasses
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"5char"] verifyItIsNotEmpty];
    }];

    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 0, kErrorIncorrectlyGenerated);
}

- (void)testThatAnEmptyFieldFails
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"empty"] verifyItIsNotEmpty];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 1, kWrongNumberOFErrors);
    XCTAssert([@"The empty field must not be empty." isEqualToString:(NSString *)errors[0]], kWrongErrorMessage);
}

- (void)testThatALongEnoughFieldPasses
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"5char"] verifyItIsLongerThan:@4];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 0, kErrorIncorrectlyGenerated);
}

- (void)testThatATooShortFieldFails
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"5char"] verifyItIsLongerThan:@6];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 1, kWrongNumberOFErrors);
    XCTAssert([@"The 5char field must be longer than 6 characters." isEqualToString:(NSString *)errors[0]], kWrongErrorMessage);
}

- (void)testThatAValidEmailPasses
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"validEmail"] verifyItIsAnEmailAddress];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 0, kErrorIncorrectlyGenerated);
}

- (void)testThatAnInvalidEmailFails
{
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"invalidEmail"] verifyItIsAnEmailAddress];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 1, kWrongNumberOFErrors);
    XCTAssert([@"The invalidEmail field must be a valid email address." isEqualToString:(NSString *)errors[0]], kWrongErrorMessage);
}

- (void)testThatAMatchingFieldPasses
{
    NSString *stringToMatch = _fiveCharField.text;
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"matching"] verifyItMatches:stringToMatch withDescription:@"5charfield"];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 0, kErrorIncorrectlyGenerated);
}

- (void)testThatANonMatchingFieldFails
{
    NSString *stringToMatch = _numberField.text;
    NSArray *errors = [VerificationTest forInputs:_inputFields andTestCases:^(VerificationTest *inspect) {
        [inspect[@"matching"] verifyItMatches:stringToMatch withDescription:@"number field"];
    }];
    
    XCTAssertNotNil(errors, kNoArrayErrorMessage);
    XCTAssert([errors count] == 1, kWrongNumberOFErrors);
    XCTAssert([@"The matching field must match the number field." isEqualToString:(NSString *)errors[0]], kWrongErrorMessage);
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

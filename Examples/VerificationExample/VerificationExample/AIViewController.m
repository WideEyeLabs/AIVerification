//
//  AIViewController.m
//  VerificationExample
//
//  Created by Brian Thomas on 12/9/13.
//  Copyright (c) 2013 WideEyeLabs. All rights reserved.
//

#import "AIViewController.h"
#import <AIVerification.h>

@interface AIViewController ()

@end

@implementation AIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
// Example Change
    
    NSArray *errors = [VerificationTest forInputs:@{} andTestCases:^(VerificationTest *inspect) {
        [inspect.tableView[@"Name"] verifyARowIsSelected];
        [inspect.textField[@"Email"] verifyItIsAnEmailAddressWithError:@"MAKE IT AN EMAIL ADDY!"];
        [inspect.textField[@"Another"] verifyItIsLongerThan:@3 withError:@"The length field must be longer than 3"];
    }];
    
    if ([errors count] != 0) {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

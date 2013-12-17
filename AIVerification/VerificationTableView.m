//
//  VerificationTableView.m
//  Pods
//
//  Created by Brian Thomas on 12/16/13.
//
//

#import "VerificationTableView.h"

@implementation VerificationTableView

- (UITableView *)objectForKeyedSubscript:(id)key
{
    id fieldForReturn = self.tester[key];
    return (UITableView *)fieldForReturn;
}

@end

//
//  VerificationTableView.h
//  Pods
//
//  Created by Brian Thomas on 12/16/13.
//
//

#import "VerificationUIView.h"

@interface VerificationTableView : VerificationUIView

- (UITableView *)objectForKeyedSubscript:(id <NSCopying>)key;

@end

//
//  VerificationTextField.h
//  Pods
//
//  Created by Brian Thomas on 12/13/13.
//
//

#import <Foundation/Foundation.h>
#import "VerificationUIView.h"

@interface VerificationTextField : VerificationUIView

- (UITextField *)objectForKeyedSubscript:(id <NSCopying>)key;

@end

[![Build
Status](https://travis-ci.org/WideEyeLabs/AIVerification.png)](https://travis-ci.org/WideEyeLabs/AIVerification)


AIVerification is a testing library for verifying user inputs.

## How To Get Started

Install [CocoaPods](http://github.com/CocoaPods/CocoaPods) and in your Podfile
>`pod 'AIVerification', git: 'https://github.com/WideEyeLabs/AIVerification.git`

### Using AIVerification

After importing the AIVerification header, all of the methods required
for testing are accesible.

## Example

```objective-c
#import <AIVerification.h>

// ..
// ..
NSDictionary *inputViews = @{ @"Name" : _nameField, @"Password" : _passwordField, @"Confirmation" : _confirmationField };
NSString *passwordText = self.passwordField.text;

NSArray *errors = [VerificationTest forInputs:inputViews andTestCases:^(VerificationTest *inspect) {
  [inspect[@"Name"] verifyItIsNotEmpty];
  [inspect[@"Password"] verifyItIsLongerThan:@6];
  [inspect[@"Confirmation"] verifyItMatches:passwordText withDescription:@"Password Field"];
}];

if ([errors count] != 0)
{
  // handle errors
  NSString *errorMessage = [errors componentsJoinedByString:@"\n\n"];
}
else
{
  // proceed
}
```



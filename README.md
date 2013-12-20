[![Build
Status](https://travis-ci.org/WideEyeLabs/AIVerification.png)](https://travis-ci.org/WideEyeLabs/AIVerification)


AIVerification is a testing library for verifying user inputs. 

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for
Objective-C, which automates and simplifies the process of using
3rd-party libraries in your projects.

#### In Your Podfile

```ruby
platform :ios, '7.0'
pod 'AIVerification', git: 'https://github.com/WideEyeLabs/AIVerification.git`
```

### About AIVerification

After importing the AIVerification header, you can access all of the
methods required for testing. Verifications are simple human readable assertions that generate error messages to be returned at the end of the testing block. The syntax should be used as follows...
````objective-c
NSArray *errors = [VerificationTest 
forInputs:inputViews 
andTestCases:^(VerificationTest *inspect) {
  [inspect.textField[@"Name"] verifyItIsNotEmpty];
}];
// Full example below
```
If the test fails, the errors array will be populated with error
messages that can be displayed to the user.  These errors can be
customized by calling the verification methods that also take an NSString
error argument.

Because it is a framework of testing objects instead of a subclass of UITextField, AIVerification plays well with any subclasses of UITextField you may want to include in your project.

### "Is This For Me?"

Known about shortfalls of this framework include...

- No callbacks to natively support continuous testing (try [TSValidatedTextField](https://github.com/appunite/TSValidatedTextField))
- Verification methods are only meangingful when called from within a test block.
- The set of verification methods is currently very limited.

## Example

```objective-c
#import <AIVerification.h>

// ..
// ..
NSDictionary *inputViews = @{ @"Name" : _nameField, 
@"Password" : _passwordField, 
@"Confirmation" : _confirmationField };

NSString *passwordText = self.passwordField.text;

NSArray *errors = [VerificationTest 
forInputs:inputViews 
andTestCases:^(VerificationTest *inspect) {
  [inspect.textField[@"Name"] verifyItIsNotEmpty];
  [inspect.textField[@"Password"] verifyItIsLongerThan:@6];
  [inspect.textField[@"Confirmation"] verifyItMatches:passwordText 
withDescription:@"Password Field"];
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



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
pod 'AIVerification', git: 'https://github.com/WideEyeLabs/AIVerification.git'
```

### About AIVerification

To get started simply import the AIVerification header (#import <AIVerification.h>). Verifications are simple human readable assertions that test the state of subclasses of UIView. After it has run, a VerificationTest generates error messages for each of the assertions that failed which can then be displayed to the user. The following is an example test with a single assertion...
````objective-c
NSArray *errors = [VerificationTest forInputs:inputViews 
        andTestCases:^(VerificationTest *inspect) {
  [inspect.textField[@"Name"] verifyItIsNotEmpty];
}];
// Full example below
```
If the assertion in this test fails, the errors array will be populated with the error
string "The Name field must not be empty". Error messages can be
customized by calling the verification methods that also takes an NSString
error as an argument (e.g., verifiyItIsNotEmptyWithError:(NSString)).

Because it is a framework that tests by inspecting objects instead of using subclassing, AIVerification plays well with any UIView subclasses you may want to include in your project (try [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField)).

### "Is This For Me?"

Of course you need more information to determine if this will be useful to you. Here are some points about AIVerification to consider.

- No callbacks to support continuous testing on changes to inputs (try [TSValidatedTextField](https://github.com/appunite/TSValidatedTextField))
- Verification assertions are only meangingful when called from within a test block (they currently have a void return).
- The set of verification assertions is currently very limited. However,
  adding new ones is a fairly simple task.

## Full Example

```objective-c
#import <AIVerification.h>

// ..
// ..
NSDictionary *inputViews = @{ @"Name" : _nameField, 
        @"Password" : _passwordField, 
        @"Confirmation" : _confirmationField };

NSString *passwordText = self.passwordField.text;

NSArray *errors = [VerificationTest forInputs:inputViews 
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



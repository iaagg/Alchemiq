# Alchemiq

[![Version](https://img.shields.io/cocoapods/v/Alchemiq.svg?style=flat)](http://cocoapods.org/pods/Alchemiq)
[![License](https://img.shields.io/cocoapods/l/Alchemiq.svg?style=flat)](http://cocoapods.org/pods/Alchemiq)
[![Platform](https://img.shields.io/cocoapods/p/Alchemiq.svg?style=flat)](http://cocoapods.org/pods/Alchemiq)

**Alchemiq** was created to provide possibility of using mixins *(aka traits)* in Objective-C. 
Inspired by mixin ideas in Ruby modules and Swift protocol extensions. 
Different from https://github.com/vl4dimir/ObjectiveMixin in much more convenient API. 
Just like in Swift, you just need to make your class to conform some Mixin (Protocol actually), and all implementation for this mixin will be added to your class in runtime. 
What is convenient - after adopting some mixin, you can call any methods (class methods, instance methods, setters and getters) without any type casting.

Brilliant, huh?! ^^

## How to start

1. First, you need to call method **[AQAlchemiq addMixins]** in your AppDelegate

```obj-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
[AQAlchemiq addMixins];
return YES;
}
```
Doing this you start process of collecting all mixins, their descriptions and your classes you want to conform some mixin!

2. To create your own mixin, you have a protocol **AQMixin** and class **AQMixinDescription**
+ Create your own mixin (protocol), which **has to** conform AQMixin protocol. You are may add @required methods&properties as well as @optional (Alchemiq prevents any warnings in your class conforming mixin protocol).
```obj-c
@protocol SomeMixin <AQMixin>
//Add your methods or properties here
@end
```
+ You can conform your mixin to any other protocols in addition to AQMixin. Only implemented methods from that protocols will be injected into your class.
```obj-c
@protocol SomeMixin <AQMixin, UITableViewDataSource, UITableViewDelegate>
//Add your methods or properties here
@end
```
+ Then you have to add implementation for your mixin, which will be injected to your class. 
What is important about mixin description (implementation)
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
ios 7.0 or higher

## Installation

Alchemiq is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Alchemiq"
```


## Author

Aleksey Getman, getmanag@gmail.com

## License

Alchemiq is available under the MIT license. See the LICENSE file for more info.

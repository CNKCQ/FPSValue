# FPSValue
show FPS value on window

##### :eyes: See also:
![fps 2x](https://cloud.githubusercontent.com/assets/8440220/17470727/2bcc7ab8-5d71-11e6-999e-e68875652c6f.png)
### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
> CocoaPods 0.39.0+ is required to build FPSValue.

To integrate FPSValue into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'FPSValue', '~> 1.0.1'
end
```
Then, run the following command:

```bash
$ pod install
```

## :book: Usage
  ``` bash
  FPSStatus.shareInstance.open()
  ```
Language|platform|tool
---|----|---
Swift 2.2|>=iOS 8.0|Xcode 7.3.1

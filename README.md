# WSModel
[![CI Status](https://img.shields.io/travis/nlgb/WSModel.svg?style=flat)](https://travis-ci.org/nlgb/WSModel)
[![Version](https://img.shields.io/cocoapods/v/WSModel.svg?style=flat)](https://cocoapods.org/pods/WSModel)
[![License](https://img.shields.io/cocoapods/l/WSModel.svg?style=flat)](https://cocoapods.org/pods/WSModel)
[![Platform](https://img.shields.io/cocoapods/p/WSModel.svg?style=flat)](https://cocoapods.org/pods/WSModel)

一款轻量级Objective-C的json解析库(A lightweight json-model lib for Objective-C)
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements


## Installation
### Cocoapods
WSModel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WSModel'
```

### Source code
把WSModel/Classes文件夹下的所有.h、.m文件拖入工程中。

## Usage

1.引入主头文件`#import <WSModel/WSModel.h>`或`#import WSModel.h`
2.使用静态方法`+ (id)modelWithJson:(id)json;`进行json-model转换。
### replaceJsonKeysWithProperties
如果Model中的property对应的json的key不同名。则需要覆写`- (NSDictionary<NSString *, NSString *> *)replaceJsonKeysWithProperties;`方法.该方法返回一个字典.字典的key和value都是`NSString *`类型。其中key是jsonkey，value是property。如下：
```objc
@interface GiftModel : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) NSInteger giftId;
@end

@implementation GiftModel
- (NSDictionary *)replaceJsonKeysWithProperties {
    // json中的id将被解析为giftId
    return @{@"id":@"giftId"};
}
@end

```

### arrayContainsCustomClass
如果Model中的property是一个数组，而这个数组中又包含若干个自定义类。则需要覆`- (NSDictionary<NSString *, NSString *> *)arrayContainsCustomClass;`方法.该方法返回一个字典.字典的key和value都是`NSString *`类型。其中key是数组名，value是数组中包含的自定义类型。如下：
```objc
@interface ItemModel: NSObject
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,assign) unsigned long long time;
@property(nonatomic,assign) NSInteger status;
@property(nonatomic,strong) NSArray<UserModel *> *user;
@end

@implementation ItemModel
- (NSDictionary *)arrayContainsCustomClass {
    // user数组中包含的是若干个UserModel对象
    return @{@"user":@"UserModel"};
}
@end

```

## Author

wangsong, wanggyanmo@163.com

## License

WSModel is available under the MIT license. See the LICENSE file for more info.

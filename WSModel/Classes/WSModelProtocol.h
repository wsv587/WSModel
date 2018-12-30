//
//  WSModelProtocol.h
//  WSJsonModel
//
//  Created by wangsong on 2018/3/24.
//  Copyright © 2018 wangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WSModelProtocol <NSObject>
@optional
/// 当json 中的key和property不能对应时
/// 使用指定的property 解析 json 中对应的key
/// 返回一个字典 key是json key, value 是property
- (NSDictionary *)replaceJsonKeysWithProperties;

/// 当json 中的的数组包含的元素（这个元素可能是一个字典.也可能是一个自定义类，比如NSString的子类）对应的是一个自定义类时
/// 使用自定义的类解析json数组中的每一个元素
/// 返回一个字典 key是数组名， value是数组中包含的自定义类型
- (NSDictionary *)arrayContainsCustomClass;

/// 忽略列表 ignorelist中包含的json key不参与解析
/// 如果一个 json key 没有被加入ignorelist中，且 model中没有对应的property/instance variable 解析它，那么debug环境下就会抛出setValue:forUndefinedKey:错误
- (NSArray *)ignorelist;
@end

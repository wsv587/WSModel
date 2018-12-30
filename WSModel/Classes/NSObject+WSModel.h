//
//  NSObject+WSModel.h
//  WSJsonModel
//
//  Created by wangsong on 2018/3/24.
//  Copyright © 2018 wangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WSModel)
///json 转 model 对外公共方法 json 可以是字符串、NSData、字典、数组
///解析成功返回对应的模型或者模型数组，解析失败返回nil
+ (id)modelWithJson:(id)json;

@end


//
//  NSObject+WSJsonToModel.m
//  WSJsonModel
//
//  Created by wangsong on 2018/3/24.
//  Copyright © 2018 wangsong. All rights reserved.
//

#import "NSObject+WSJsonToModel.h"
#import <objc/runtime.h>
#import "WSPropertyInfo.h"
#import "WSBOOLTranslator.h"

@implementation NSObject (WSJsonToModel)
- (void)custom_setValue:(id)value forKey:(nonnull NSString *)key {
    if (value == nil || value == NULL || [value isKindOfClass:[NSNull class]] || key == nil) {
        return;
    }
    
    /// 忽略不解析的属性
    NSArray *ignorelist = [self p_ignorelist];
    if (ignorelist && [ignorelist containsObject:key]) {
        return;
    }
    
    /// json中的字段对应另一个property
    NSDictionary *replaceMap = [self p_replaceMap];
    if (replaceMap && [replaceMap objectForKey:key]) {
        key = [replaceMap objectForKey:key];
    }
    
    [self setValue:value forKey:key];
}

- (void)ws_setKeyValues:(id)keyedValues {
    
    unsigned int propertyCount = 0;
    objc_property_t *propertylist = class_copyPropertyList([self class], &propertyCount);
    
    /// 遍历property
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = propertylist[i];
        WSPropertyInfo *ptyInfo = [WSPropertyInfo propertyInfoForProperty:property];
        NSString *className = ptyInfo.className;
        NSString *propertyName = ptyInfo.propertyName;
        
        /// 基本数据类型类名为nil
        if (!ptyInfo.isObjectClass) {
            id value = [keyedValues objectForKey:propertyName];
            if (value == nil) {
                value = [self getJsonValueForPropertyName:propertyName keyedValues:keyedValues];
            }
            if (ptyInfo.isBoolClass) {
                BOOL res = [WSBOOLTranslator translate:value];
                [self custom_setValue:@(res) forKey:propertyName];
            } else {
                /// 基本数据类型
                /// 如果json是string而非number，KVC也会自动转换
                [self custom_setValue:value forKey:propertyName];
            }
            
            continue;
        }
        
        /// 到这里说明property是对象类型
        /// 判断property所属的类是不是原生类
        BOOL isProtogenic = [WSPropertyInfo isProtogenicClass:className];
        /// 取json(可能是字典也可能是字符串)
        id value = [keyedValues objectForKey:propertyName];
        if (value == nil) {
            value = [self getJsonValueForPropertyName:propertyName keyedValues:keyedValues];
        }
        if (isProtogenic) {
            /// 是原生类
            if (ptyInfo.isArrayClass) {
                /// 是数组
                [self handledAsArrayWithPropertyInfo:ptyInfo value:value];
                continue;
            } else {
                /// 不是数组
                if (ptyInfo.isURLClass) {
                    if ([value isKindOfClass:[NSString class]]) {
                        value = [NSURL URLWithString:value];
                    }
                    [self custom_setValue:value forKey:propertyName];
                } else if (ptyInfo.isStringClass) {
                    if ([value isKindOfClass:[NSNumber class]]) {
                        value = [NSString stringWithFormat:@"%@",value];
                    }
                    [self custom_setValue:value forKey:propertyName];
                } else if (ptyInfo.isNumberClass) {
                    if ([value isKindOfClass:[NSString class]]) {
                        value = @([value integerValue]);
                    }
                    [self custom_setValue:value forKey:propertyName];
                } else {
                    [self custom_setValue:value forKey:propertyName];
                }
            }
            
        } else {
            /// 不是原生类
            /// 字典转model
            if ([value isKindOfClass:[NSDictionary class]]) {
                Class cls = NSClassFromString(className);
                id one = [cls new];
                [one ws_setKeyValues:value];
                [self custom_setValue:one forKey:propertyName];
            }
        }
    }
    
    free(propertylist);
}

- (id)getJsonValueForPropertyName:(NSString *)propertyName keyedValues:(NSDictionary<NSString *,id> *)keyedValues {
    id value = nil;
    
    NSDictionary *replaceMap = [self p_replaceMap];
    NSArray *allKeys = [replaceMap allKeys];
    NSArray *allValues = [replaceMap allValues];
    
    if ([allValues containsObject:propertyName]) {
        NSUInteger index = [allValues indexOfObject:propertyName];
        NSString *key = [allKeys objectAtIndex:index];
        value = [keyedValues objectForKey:key];
    }
    
    return value;
}

- (BOOL)handledAsArrayWithPropertyInfo:(WSPropertyInfo *)propertyInfo value:(id)value {
    if (propertyInfo == nil || value == nil) {
        return NO;
    }
    NSString *propertyName = propertyInfo.propertyName;
    
    if (![self respondsToSelector:@selector(arrayContainsCustomClass)]) { /// 未实现协议方法 按照普通数组处理
        [self custom_setValue:value forKey:propertyName];
        return NO;
    }
    
    NSDictionary *customClassInArrayMap = [self arrayContainsCustomClass];
    if (!customClassInArrayMap ||
        ![customClassInArrayMap count] ||
        ![customClassInArrayMap objectForKey:propertyName]) { /// 协议方法返回nil 按普通数组处理
        [self custom_setValue:value forKey:propertyName];
        return  NO;
    }
    
    id customClassInArray = [customClassInArrayMap objectForKey:propertyName];
    if (!customClassInArray) { /// 数组中不包含自定义类  按普通数组处理
        [self custom_setValue:value forKey:propertyName];
        return NO;
    }
    
    /// 到这里说明：当前property是数组类型 && 指定了数组中包含的自定义类
    if ([customClassInArray isKindOfClass:[NSString class]]) {
        Class cls = NSClassFromString((NSString *)customClassInArray);
        /// 容错
        if (![value isKindOfClass:[NSArray class]]) {
            value = [NSArray arrayWithObject:value];
        }
        if (!cls) {
            NSAssert(NO, @"cls不能为空");
            return YES;
        }
        if (!value || ![value count]) {
            return YES;
        }
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < [value count]; i++) {
            id one = [cls new];
            id dict = [(NSArray *)value objectAtIndex:i];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                [one ws_setKeyValues:dict];
                [tempArray addObject:one];
            } else if ([dict isKindOfClass:[NSArray class]]) { }
        }
        
        if (propertyInfo.isArrayClass && propertyInfo.isMutableArrayClass) {
            /// 可变数组
            [self custom_setValue:tempArray forKey:propertyName];
        } else if (propertyInfo.isArrayClass) {
            /// 不可变数组
            [self custom_setValue:[tempArray copy] forKey:propertyName];
        }
    } else {
        NSAssert(NO, @"自定义类型必须是字符串");
        return YES;
    }
    return NO;
}

#pragma mark -
- (NSDictionary *)p_replaceMap {
    if ([self respondsToSelector:@selector(replaceJsonKeysWithProperties)]) {
        return [self replaceJsonKeysWithProperties];
    }
    return nil;
}

- (NSArray *)p_ignorelist {
    if ([self respondsToSelector:@selector(ignorelist)]) {
        return [self ignorelist];
    }
    return nil;
}
@end

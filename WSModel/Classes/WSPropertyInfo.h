//
//  WSPropertyInfo.h
//  WSJsonModel
//
//  Created by wangsong on 2018/3/24.
//  Copyright © 2018 wangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface WSPropertyInfo : NSObject
/**
 * 属性
 */
@property(nonatomic, assign) objc_property_t property;

/**
 * 属性名
 */
@property(nonatomic, copy) NSString *propertyName;
/**
 * 属性的attributes
 */
@property(nonatomic, copy) NSString *attributes;

/**
 * property是否是对象类型
 */
@property(nonatomic, assign, getter=isObjectClass) BOOL objectClass;

/**
 * property的所属类型的code
 * 例如：NSInteger的classCode是q; int的classCode是i; double的classCode是d
 * 对象类型的classCode和className是一样的 比如：NSString的classCode也是NSString
 */
@property(nonatomic, copy) NSString *classCode;

/**
 * property所属的类型
 * 如果property是对象类型className是其所属的类
 * 如果property是基本数据类型，那么className是nil
 */
@property(nonatomic, copy) NSString *className;

/**
 * property是否是id类型
 */
@property(nonatomic, assign, getter=isIdClass) BOOL idClass;

/**
 * 是否是BOOL类型
 */
@property(nonatomic, assign, getter=isBoolClass) BOOL BoolClass;

/**
 * 是否是Char类型
 */
@property(nonatomic, assign, getter=isCharClass) BOOL charClass;

/**
 * 是否是数组类型
 */
@property(nonatomic, assign, getter=isArrayClass) BOOL arrayClass;

/**
 * 是否是可变数组
 */
@property(nonatomic, assign, getter=isMutableArrayClass) BOOL mutableArrayClass;

/**
 * 是否是NSURL类型
 */
@property(nonatomic, assign, getter=isURLClass) BOOL urlClass;

/**
 * 是否是字符串类型
 */
@property(nonatomic, assign, getter=isStringClass) BOOL stringClass;

/**
 * 是否是NSNumber类型
 */
@property(nonatomic, assign, getter=isNumberClass) BOOL numberClass;


+ (BOOL)isClassWithAttributtes:(NSString *)attr;
+ (NSString *)classNameWithAttributes:(NSString *)attr;
+ (BOOL)isProtogenicClass:(NSString *)className;
+ (BOOL)isArray:(NSString *)className;

/**
 * 获取某个属性的所有信息
 * 要获取信息的属性
 * 获取的信息被封装在KVCClassInfo对象内部
 */
+ (instancetype)propertyInfoForProperty:(objc_property_t)property;
- (BOOL)isArray:(NSString *)className;

@end

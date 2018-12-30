//
//  WSPropertyInfo.m
//  WSJsonModel
//
//  Created by wangsong on 2018/3/24.
//  Copyright © 2018 wangsong. All rights reserved.
//

#import "WSPropertyInfo.h"

@implementation WSPropertyInfo
+ (instancetype)propertyInfoForProperty:(objc_property_t)property {
    
    static dispatch_semaphore_t signalSemaphore;
    static dispatch_once_t onceTokenSemaphore;
    dispatch_once(&onceTokenSemaphore, ^{
        signalSemaphore = dispatch_semaphore_create(1);
    });
    
    dispatch_semaphore_wait(signalSemaphore, DISPATCH_TIME_FOREVER);
    
    WSPropertyInfo *instance = [WSPropertyInfo new];
    
    instance.property = property;
    
    /// 属性名
    const char *propertyName = property_getName(property);
    NSString *propertyString = [[NSString alloc] initWithCString:propertyName encoding:NSUTF8StringEncoding];
    instance.propertyName = propertyString;
    
    /// property 的attributes(包括变量名、类型) 根据attributes获取类型
    const char *attributes = property_getAttributes(property);
    NSString *attributesString = [[NSString alloc] initWithCString:attributes encoding:NSUTF8StringEncoding];
    instance.attributes = attributesString;
    
    /// 是否是对象类型
    BOOL isObjectClass = [instance isClassWithAttributtes:attributesString];
    instance.objectClass = isObjectClass;
    
    /// 类名 && 类型code
    if (isObjectClass) {
        instance.idClass = [instance isIdClassWithAttributtes:attributesString];
        if (instance.isIdClass) {
            instance.className = @"id";
            instance.classCode = @"@";
        } else {
            instance.className = [instance classNameWithAttributes:attributesString];
            instance.classCode = instance.className;
            instance.urlClass = [instance isURL:instance.className];
            instance.arrayClass = [instance isArray:instance.className];
            instance.stringClass = [instance isString:instance.className];
            instance.numberClass = [instance isNumber:instance.className];
        }
    } else {
        instance.className = nil;
        instance.classCode = [instance classNameWithAttributes:attributesString];
        instance.BoolClass = [instance isBOOLClassWithAttributtes:attributesString];
        instance.charClass = [instance isCharClassWithAttributtes:attributesString];
    }
    
    dispatch_semaphore_signal(signalSemaphore);
    
    return instance;
    
}

/// 是否是char/Boolean类型 char 和 Boolean类型都是 C
- (BOOL)isCharClassWithAttributtes:(NSString *)attr {
    if (!attr || ![attr length]) {
        NSAssert(attr && [attr length], @"运行时错误，property的attr不能为空");
        return NO;
    }
    
    if (![attr hasPrefix:@"TC,"]) {
        return NO;
    }
    return YES;
}

/// 是否是BOOL类型
- (BOOL)isBOOLClassWithAttributtes:(NSString *)attr {
    if (!attr || ![attr length]) {
        NSAssert(attr && [attr length], @"运行时错误，property的attr不能为空");
        return NO;
    }
    if (![attr hasPrefix:@"TB,"]) {
        return NO;
    }
    return YES;
    
}

/// 是否是字符串类型
- (BOOL)isString:(NSString *)className {
    NSParameterAssert(className && [className length]);
    if (!className || ![className length]) {
        return NO;
    }
    
    if ([className isEqualToString:@"NSString"] || [className isEqualToString:@"NSMutableString"]) {
        self.stringClass = YES;
        return YES;
    }
    
    Class cls = NSClassFromString(className);
    if ([cls isSubclassOfClass:[NSString class]]) {
        self.stringClass = YES;
        return YES;
    }
    
    return NO;
}

/// 是否是number类型
- (BOOL)isNumber:(NSString *)className {
    NSParameterAssert(className && [className length]);
    if (!className || ![className length]) {
        return NO;
    }
    
    if ([className isEqualToString:@"NSNumber"] || [className isEqualToString:@"NSDecimalNumber"]) {
        self.numberClass = YES;
        return YES;
    }
    
    Class cls = NSClassFromString(className);
    if ([cls isSubclassOfClass:[NSNumber class]]) {
        self.numberClass = YES;
        return YES;
    }
    
    return NO;
}


/// 是否是URL类型
- (BOOL)isURL:(NSString *)className {
    NSParameterAssert(className && [className length]);
    if (!className || ![className length]) {
        return NO;
    }
    
    if ([className isEqualToString:@"NSURL"]) {
        self.urlClass = YES;
        return YES;
    }
    
    Class cls = NSClassFromString(className);
    if ([cls isSubclassOfClass:[NSURL class]]) {
        self.urlClass = YES;
        return YES;
    }
    
    return NO;
}

/// 是否是id类型
- (BOOL)isIdClassWithAttributtes:(NSString *)attr {
    if (!attr || ![attr length]) {
        NSAssert(attr && [attr length], @"运行时错误，property的attr不能为空");
        return NO;
    }
    if (![attr hasPrefix:@"T@,"]) {
        return NO;
    }
    return YES;
}

/// 是否是对象类型
- (BOOL)isClassWithAttributtes:(NSString *)attr {
    if (!attr || ![attr length]) {
        NSAssert(attr && [attr length], @"运行时错误，property的attr不能为空");
        return YES;
    }
    
    /// 不包含 T@" 或 T@,前缀，说明既不是对象类型，又不是id类型
    if (![attr hasPrefix:@"T@\""] && ![attr hasPrefix:@"T@,"]) {
        return NO;
    }
    return YES;
}

/// 返回类型名称
- (NSString *)classNameWithAttributes:(NSString *)attr {
    if (!attr || !attr.length) return nil;
    
    if (![attr hasPrefix:@"T@\""]) { /// 如果attributes中不包含 T@" 认定为变量不是对象类型
        NSUInteger dotLoc = [attr rangeOfString:@","].location;
        NSRange typeR = NSMakeRange(1, dotLoc - 1);
        NSString *type = [attr substringWithRange:typeR];
        return type;
    }
    
    NSRange firstR = [attr rangeOfString:@"T@\""];
    NSRange lastR = [attr rangeOfString:@"\","];
    
    NSUInteger firstLoc = firstR.location + firstR.length;
    NSUInteger lastLoc = lastR.location;
    
    NSRange r = NSMakeRange(firstLoc, lastLoc - firstLoc);
    
    NSString *className = [attr substringWithRange:r];
    
    return className;
}

/// 是否是数组或其衍生类

- (BOOL)isArray:(NSString *)className {
    NSParameterAssert(className && [className length]);
    if (!className || ![className length]) {
        return NO;
    }
    
    if ([className isEqualToString:@"NSMutableArray"]) {
        self.mutableArrayClass = YES;
        self.arrayClass = YES;
        return YES;
    }
    
    if ([className isEqualToString:@"NSArray"]) {
        self.arrayClass = YES;
        return YES;
    }
    
    Class cls = NSClassFromString(className);
    if ([cls isSubclassOfClass:[NSMutableArray class]]) {
        self.mutableArrayClass = YES;
        self.arrayClass = YES;
        return YES;
    }
    
    if ([cls isSubclassOfClass:[NSArray class]]) {
        self.arrayClass = YES;
        return YES;
    }
    return NO;
}


#pragma mark - Class Method
///返回是否对象类型
+ (BOOL)isClassWithAttributtes:(NSString *)attr {
    if (!attr || ![attr length]) {
        NSAssert(attr && [attr length], @"运行时错误，property的attr不能为空");
        return YES;
    }
    if (![attr hasPrefix:@"T@\""]) {
        return NO;
    }
    
    return YES;
}

/// 返回类型名称
+ (NSString *)classNameWithAttributes:(NSString *)attr {
    if (!attr || !attr.length) return nil;
    
    if (![attr hasPrefix:@"T@\""]) { /// 如果attributes中不包含 T@" 认定为变量不是对象类型
        return nil;
    }
    
    NSRange firstR = [attr rangeOfString:@"T@\""];
    NSRange lastR = [attr rangeOfString:@"\","];
    
    NSUInteger firstLoc = firstR.location + firstR.length;
    NSUInteger lastLoc = lastR.location;
    
    NSRange r = NSMakeRange(firstLoc, lastLoc - firstLoc);
    
    NSString *className = [attr substringWithRange:r];
    
    return className;
}

/// 返回是否是原生类
+ (BOOL)isProtogenicClass:(NSString *)className {
    NSParameterAssert(className && [className length]);
    if (!className || ![className length]) {
        return NO;
    }
    
    Class protogenicClass = [[self protogenicClassMap] objectForKey:className];
    if (protogenicClass) {
        return YES;
    }
    
    NSArray<Class> *classArr = [[self protogenicClassMap] allValues];
    
    Class cls = NSClassFromString(className);
    __block BOOL isProtogenicClass = NO;
    [classArr enumerateObjectsUsingBlock:^(id  _Nonnull protogenicCls, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([cls isSubclassOfClass:protogenicCls]) {
            isProtogenicClass = YES;
            *stop = YES;
        }
    }];
    
    return isProtogenicClass;
}

/// 是否是数组或其衍生类
+ (BOOL)isArray:(NSString *)className {
    NSParameterAssert(className && [className length]);
    if (!className || ![className length]) {
        return NO;
    }
    
    if ([className isEqualToString:@"NSArray"] || [className isEqualToString:@"NSMutableArray"]) {
        return YES;
    }
    
    Class cls = NSClassFromString(className);
    if ([cls isSubclassOfClass:[NSArray class]]) {
        return YES;
    }
    
    return NO;
}

+ (NSDictionary<NSString *, Class> *)protogenicClassMap {
    static NSDictionary *_protogenicClassMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_protogenicClassMap) {
            _protogenicClassMap = @{@"NSURL":[NSURL class],
                                    @"NSData":[NSData class],
                                    @"NSDate":[NSDate class],
                                    @"NSString":[NSString class],
                                    @"NSNumber":[NSNumber class],
                                    @"NSValue":[NSValue class],
                                    @"NSError":[NSError class],
                                    @"NSArray":[NSArray class],
                                    @"NSDictionary":[NSDictionary class],
                                    @"NSDecimalNumber":[NSDecimalNumber class],
                                    @"NSAttributedString":[NSAttributedString class]
                                    };
        }
    });
    
    return _protogenicClassMap;
}
@end

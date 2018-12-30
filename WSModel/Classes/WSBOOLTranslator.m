//
//  WSBOOLTranslator.m
//  WSJsonModel
//
//  Created by wangsong on 2018/3/24.
//  Copyright © 2018 wangsong. All rights reserved.
//

#import "WSBOOLTranslator.h"

@implementation WSBOOLTranslator
+ (BOOL)translate:(id)value {
    if (!value) {
        return NO;
    }
    if ([value isKindOfClass:[NSString class]]) {
        value = [value lowercaseString];
        if ([value isEqualToString:@"true"] || [value isEqualToString:@"yes"] || [value integerValue]) {
            return YES;
        } else if ([value isEqualToString:@"false"] || [value isEqualToString:@"no"] || [value integerValue] == 0) {
            return NO;
        } else {
            NSAssert(NO, @"转换失败");
            return NO;
        }
    }
    
    if ([value isKindOfClass:[NSNumber class]]) {
        if ([value isEqualToNumber:@0]) {
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}
@end

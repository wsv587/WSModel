//
//  NSObject+WSModel.m
//  WSJsonModel
//
//  Created by wangsong on 2018/3/24.
//  Copyright © 2018 wangsong. All rights reserved.
//

#import "NSObject+WSModel.h"
#import "NSObject+WSJsonToModel.h"

@implementation NSObject (WSModel)
#pragma mark - Public
+ (id)modelWithJson:(id)json {
    if ([json isKindOfClass:[NSString class]]) {
        json = [json dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if ([json isKindOfClass:[NSData class]]) {
        NSError *error = nil;
        json = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:&error];
        if (!json || error) {
            NSAssert(error == nil, @"data转json失败");
            return nil;
        }
    }
    
    if ([json isKindOfClass:[NSDictionary class]]) {
        return [self modelWithDict:json];
    }
    
    if ([json isKindOfClass:[NSArray class]]) {
        return [self modelsWithArray:json];
    }
    
    NSAssert(NO, @"当前的json类型-%@不支持",[json class]);
    return nil;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:[NSDictionary class]])  {
        return nil;
    }
    id model = [self new];
    [model ws_setKeyValues:dict];
    
    return model;
}

+ (NSArray *)modelsWithArray:(NSArray *)array {
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            id one = [self modelWithDict:dict];
            [models addObject:one];
        }
    }
    return [models copy];
}


@end

//
//  DictContainDict.m
//  JsonToModel
//
//  Created by sw on 2018/6/7.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "BookContainAuthor.h"

@implementation Author
@end

@implementation BookContainAuthor
#warning jsonkey 和 property不一致时，不实现这个方法就崩溃
- (NSDictionary *)replaceJsonKeysWithProperties {
    return @{@"id":@"ID"};
}

- (NSDictionary *)arrayContainsCustomClass {
    return @{@"alias":@"NSString",@"secondAuthor":@"Author"};
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    if ([key isEqualToString:@"id"]) {
//        [self setValue:value forKey:@"ID"];
//    }
//}


@end

//
//  ArrayContainDictionaryModel.m
//  JsonToModel
//
//  Created by sw on 2018/6/12.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "ArrayContainDictionaryModel.h"

@implementation ArrayContainDictionaryModel
- (NSDictionary *)replaceJsonKeysWithProperties {
    return @{@"id":@"giftId"};
}
@end

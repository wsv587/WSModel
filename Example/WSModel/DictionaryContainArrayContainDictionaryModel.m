//
//  DictionaryContainArrayContainDictionaryModel.m
//  JsonToModel
//
//  Created by sw on 2018/6/12.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "DictionaryContainArrayContainDictionaryModel.h"

@implementation DictionaryContainArrayContainDictionaryModel

@end


@implementation DataModel

-(NSDictionary *)replaceJsonKeysWithProperties {
    return @{@"id":@"ID",@"newSongName":@"filteredSongName"};
}

- (NSDictionary *)arrayContainsCustomClass {
    return @{@"list":@"ItemModel"};
}
@end

@implementation ItemModel
- (NSDictionary *)replaceJsonKeysWithProperties {
    return @{@"id":@"ID"};
}

- (NSDictionary *)arrayContainsCustomClass {
    return @{@"user":@"UserModel"};
}
@end

@implementation UserModel

@end

//
//  WSViewController.m
//  WSModel
//
//  Created by nlgb on 12/30/2018.
//  Copyright (c) 2018 nlgb. All rights reserved.
//

#import "WSViewController.h"
#import <WSModel/WSModel.h>
#import "BookContainAuthor.h"
#import "ArrayContainDictionaryModel.h"
#import "DictionaryContainArrayModel.h"
#import "DictionaryContainArrayContainDictionaryModel.h"

@interface WSViewController ()

@end

@implementation WSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self parserDictWithKVC];
//    [self parserArrayContainDict];
//    [self parserDictContainArray];
//    [self parserDictContainArrayContainDict];
//    [self parserArrayContainArrayContainDict];
}

- (void)parserArrayContainArrayContainDict {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArrayContainArray.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    NSJSONSerialization *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    id models = nil;
    if (jsonObj) {
        models = [DictionaryContainArrayContainDictionaryModel modelWithJson:jsonObj];
        NSLog(@"%@",models);
    }
}


- (void)parserDictContainArrayContainDict {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DictContainArrayContainDict.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    NSJSONSerialization *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if (jsonObj) {
       id models = [DictionaryContainArrayContainDictionaryModel modelWithJson:jsonObj];
        NSLog(@"%@",models);
    }
}

- (void)parserDictContainArray {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DictContainArray.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    NSJSONSerialization *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if (jsonObj) {
        id models = [DictionaryContainArrayModel modelWithJson:jsonObj];
        for (DictionaryModel *m in [models data]) {
            NSLog(@"%@",m.avatar);
        }
    }
}

- (void)parserArrayContainDict {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArrayContainDict.txt" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    NSJSONSerialization *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if (jsonObj) {
        id models = nil;
        models = [ArrayContainDictionaryModel modelWithJson:jsonObj];
        NSLog(@"%@",models);
    }
}

- (void)parserDictWithKVC {
    BookContainAuthor *model = nil;
    model = [BookContainAuthor modelWithJson:[self dictContainDict]];
    
    NSLog(@"书名 %@,编号 %u,作者 %@,年龄 %ld, 地址%@，第二本书名 %@, 第二本编号 %u",model.name,
          model.ID,
          [[model author] authorName],
          [model author].authorAge,
          [[model author] valueForKey:@"address"],
          [model author].book.name,
          [model author].book.ID);
    
    for (Author *author in [model secondAuthor]) {
        NSLog(@"author %@",author);
        NSLog(@"author name %@",author.authorName);
    }
}

- (NSDictionary *)dictContainDict {
    return @{@"name":@"《呐喊》",
             @"link":@"http://abc.com",
             @"isOriginal":@"2",
             @"id":@"123456",
             @"author" : @{@"authorName":@"鲁迅", @"authorAge":@999, @"address":@"浙江绍兴",@"book":@{@"name":@"《彷徨》", @"id":@"987654"}}
             ,
             @"secondAuthor":@[@{@"authorName":@"王松111"},@{@"authorName":@"王松222"}]
             };
}

@end

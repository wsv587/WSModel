//
//  DictContainDict.h
//  JsonToModel
//
//  Created by sw on 2018/6/7.
//  Copyright © 2018年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class BookContainAuthor;

@interface Author: NSObject
//{
//    NSString *address;
//}


@property(nonatomic, copy) NSString *address;

@property(nonatomic, copy) NSString *authorName;
@property(nonatomic, assign) NSInteger authorAge;
@property(nonatomic, strong) BookContainAuthor *book;;


@end

@interface BookContainAuthor : NSObject
//@property (nonatomic, assign) Boolean wear; ///书名
//@property (nonatomic, assign) bool tear; ///书名
//@property (nonatomic, assign) char *tears; ///书名
@property (nonatomic, strong) NSURL *link; ///链接

@property (nonatomic, copy) NSString *name; ///书名
@property (nonatomic, assign) BOOL isOriginal; ///是否是原创
@property (nonatomic, strong) Author *author; ///作者
@property (nonatomic, assign) unsigned ID; ///编号
//@property (nonatomic, strong) NSNumber *page; ///页数
//@property (nonatomic, strong) NSDecimalNumber *advicePrice; /// 建议价格

//@property (nonatomic, strong) NSData *data; /// 测试data
//@property (nonatomic, assign) int printVersion; ///印刷批次
//@property (nonatomic, assign) CGFloat price; /// 价格
//@property (nonatomic, assign) double width; /// 宽度
//@property (nonatomic, assign) float height; /// 高度
//
//@property (nonatomic, assign) BOOL isDiscount; /// 是否打折
//
//@property (nonatomic, assign) unsigned long long chatactorNumber; /// 字数
//
//@property (nonatomic, assign) unsigned long lineNumber; /// 行数
//
//@property (nonatomic, assign) unsigned weight; /// 重量
//
//@property (nonatomic, assign) long long readerNumber; /// 读者数
//
//@property (nonatomic, assign) unsigned short uqwer; /// 无意义
@property (nonatomic, assign) unsigned char ucqwer; /// 无意义

@property (nonatomic, strong) NSArray<Author *> *secondAuthor;
//@property (nonatomic, strong) NSArray<NSArray *> *secondInfo;

@end

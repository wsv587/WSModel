//
//  ArrayContainDictionaryModel.h
//  JsonToModel
//
//  Created by sw on 2018/6/12.
//  Copyright © 2018年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>"

@interface ArrayContainDictionaryModel : NSObject

@property (nonatomic, assign) NSInteger rank;

@property (nonatomic, assign) NSInteger topCount;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *itemName;

@property (nonatomic, assign) NSInteger roomId;

@property (nonatomic, assign) CGFloat cost;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger giftId;


@end

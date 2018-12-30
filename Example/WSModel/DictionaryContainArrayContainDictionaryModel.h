//
//  DictionaryContainArrayContainDictionaryModel.h
//  JsonToModel
//
//  Created by sw on 2018/6/12.
//  Copyright © 2018年 ws. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

@class DataModel,ItemModel, UserModel;

@interface DictionaryContainArrayContainDictionaryModel : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) DataModel *data;
@property (nonatomic, copy) NSString *message;

@end

@interface DataModel: NSObject
@property(nonatomic,assign) NSInteger totalItems;
@property(nonatomic,strong) NSArray<ItemModel *> *list;
@end

@interface ItemModel: NSObject
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *songName;
@property(nonatomic,assign) unsigned long long time;
@property(nonatomic,assign) NSInteger status;
//@property(nonatomic,strong) UserModel *user;
@property(nonatomic,strong) NSArray<UserModel *> *user;

@end


@interface UserModel: NSObject
@property (nonatomic, copy, nullable) NSString *nickname;
@property (nonatomic, copy, nullable) NSString *avatar;
@property (nonatomic, unsafe_unretained) NSInteger sex;
@property (nonatomic, unsafe_unretained) NSInteger geocode;
@property (nonatomic, unsafe_unretained) long long userId;
@property (nonatomic, copy, nullable) NSString *username;
@property (nonatomic, unsafe_unretained) NSInteger newGrade;
@property (nonatomic, unsafe_unretained) NSInteger grade;
@property (nonatomic, unsafe_unretained) NSInteger userGrade;
@property (nonatomic, assign) BOOL isTrueName;
@property (nonatomic, unsafe_unretained) BOOL isSport;
@property (nonatomic, unsafe_unretained) BOOL isYearGuard;

@property (nonatomic, unsafe_unretained) NSInteger platformType;
@property (nonatomic, unsafe_unretained) NSInteger vipType; //vip类型
@property (nonatomic, unsafe_unretained) NSInteger guardType; //守护类型
@end

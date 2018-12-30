//
//  DictionaryContainArrayModel.h
//  JsonToModel
//
//  Created by sw on 2018/6/12.
//  Copyright © 2018年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryContainArrayModel : NSObject

//@property(nonatomic,assign) NSInteger code; //返回码，0为成功
@property(nonatomic,copy) NSArray *data;
//@property(nonatomic,copy) NSString *message;
//@property(nonatomic,assign) NSInteger totalCount; //贵族个数

@end

@interface DictionaryModel: NSObject
@property(nonatomic,assign) NSInteger grade;
@property(nonatomic,assign) unsigned long long joinTime;
@property(nonatomic,assign) NSInteger newGrade;
@property(nonatomic,assign) NSInteger userId;
@property(nonatomic,copy) NSString *userName;
@property(nonatomic,assign) NSInteger nobleLevel;
@property(nonatomic,copy) NSString *avatar;

@end

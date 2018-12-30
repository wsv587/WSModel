//
//  NSObject+WSJsonToModel.h
//  WSJsonModel
//
//  Created by wangsong on 2018/3/24.
//  Copyright © 2018 wangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSModelProtocol.h"

@interface NSObject (WSJsonToModel)<WSModelProtocol>
- (void)ws_setKeyValues:(id)keyedValues;
@end


//
//  SCCalendarHour.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/4/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "THBaseModel.h"

@interface SCCalendarHour : THBaseModel

/**
 小时
 */
@property(nonatomic,assign) NSInteger hour;


/**
 分钟 NSNumber
 */
@property(nonatomic,strong) NSMutableArray *minutes;

@end

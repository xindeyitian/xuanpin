//
//  SCCalendarMonth.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/4/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "THBaseModel.h"
#import "SCCalendarDay.h"

@interface SCCalendarMonth : THBaseModel


/**
 年
 */
@property(nonatomic,assign) NSInteger year;

/**
 月份
 */
@property(nonatomic,assign) NSInteger month;


/**
 天 SCCalendarDay
 */
@property(nonatomic,strong) NSMutableArray *days;

@end

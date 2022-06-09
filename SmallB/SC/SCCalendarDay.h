//
//  SCCalendarDay.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/4/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "THBaseModel.h"
#import "SCCalendarHour.h"

@interface SCCalendarDay : THBaseModel

/**
 年
 */
@property(nonatomic,assign) NSInteger year;

/**
 月份
 */
@property(nonatomic,assign) NSInteger month;

/**
 天
 */
@property(nonatomic,assign) NSInteger day;

/**
 0-6
 */
@property(nonatomic,assign) NSInteger weekday;

/**
 周几
 */
@property(nonatomic,copy) NSString *week;

/**
 小时SCCalendarHour
 */
@property(nonatomic,strong) NSMutableArray *hours;


/**
 转化成日期 精确到日
 */
- (NSDate *)date;

/**
 是否是同一天

 @param date 比较得到日期
 @return 结果是否是同一天
 */
- (BOOL)isSameDay:(NSDate *)date;
@end

//
//  NSDate+Calendar.h
//  Calender
//
//  Created by Mac on 2017/3/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)


/**
 下一天

 @return 日期
 */
- (instancetype)nextDay;
- (instancetype)nextNumDay:(NSInteger)num;

/**
 日期转日历组件

 @return 日历
 */
- (NSDateComponents *)dateComponents;


/**
 两个时间之间的所有日历
 结束时间要大于开始时间
 @param endDate 结束时间
 @return 日历数组
 */
- (NSArray *)dateComponentsBetweenDate:(NSDate *)endDate;


/**
 日历数组
 结束时间大于开始时间
 根据年分组
 @param endDate 结束日期
 @return 年为单位的数组 SCCalendarYear
 */
- (NSArray *)dateComponentsYearArrayBetweenDate:(NSDate *)endDate;

/**
 日历数组
 结束时间大于开始时间
 
 @param endDate 结束日期
 @return 月为单位的数组 SCCalendarMonth
 */
- (NSArray *)dateComponentsMonthArrayBetweenDate:(NSDate *)endDate;

/**
 日历数组
 结束时间大于开始时间
 
 @param endDate 结束日期
 @return 天为单位的数组 SCCalendarDay
 */
- (NSArray *)dateComponentsDayArrayBetweenDate:(NSDate *)endDate;
@end

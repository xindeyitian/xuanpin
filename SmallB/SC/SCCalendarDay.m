//
//  SCCalendarDay.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/4/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SCCalendarDay.h"
#import <MJExtension.h>
@implementation SCCalendarDay

- (void)setWeekday:(NSInteger)weekday
{
    _weekday = weekday;
    
    NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    _week = [NSString stringWithFormat:@"星期%@",weekArray[_weekday-1]];
}

+ (NSDictionary *)mj_objectClassInArray
{

    return @{
             @"hours":[SCCalendarHour class]
             };
}

- (NSDate *)date
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [NSDateComponents mj_objectWithKeyValues:self.mj_keyValues];
    
    NSDate *date = [calender dateFromComponents:components];
    
    return date;
    
}
- (BOOL)isSameDay:(NSDate *)date
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
   return  [calender isDate:self.date inSameDayAsDate:date];
    
}
@end

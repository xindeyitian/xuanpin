//
//  NSDate+Calendar.m
//  Calender
//
//  Created by Mac on 2017/3/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSDate+Calendar.h"
#import "SCCalendarYear.h"
#import <MJExtension.h>
#define SCHour    (60*60)

#define SCDay    (24*SCHour)

@implementation NSDate (Calendar)

- (instancetype)nextDay
{
    
    return [self dateByAddingTimeInterval:SCDay];
}
- (instancetype)nextNumDay:(NSInteger)num
{
    return [self dateByAddingTimeInterval:SCDay*num];
}
- (NSDateComponents *)dateComponents
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday;
    
    NSDateComponents *components = [calendar components:calendarUnit fromDate:self];
    
    return components;
}
- (NSArray *)dateComponentsBetweenDate:(NSDate *)endDate
{
    NSTimeInterval minusTime = endDate.timeIntervalSince1970 - self.timeIntervalSince1970;
    
    if (minusTime<0) {
        
        return nil;
    }
    
    NSInteger count = minusTime/SCDay;
    
    NSMutableArray *componentsArray = [NSMutableArray arrayWithCapacity:count];
    
    NSDate *date = self;
    
    for (NSInteger i=0; i<=count; i++) {
        
       NSDateComponents *dateComponents = [date dateComponents];
        
        if (i==count) {
            
            NSDateComponents *endDateComponents = [endDate dateComponents];
            
            if (dateComponents.day == endDateComponents.day) {
                
                [componentsArray addObject:dateComponents];
                
            }else{
            
                [componentsArray addObject:dateComponents];
                [componentsArray addObject:endDateComponents];
            
            }
            
        }else{
        
            [componentsArray addObject:dateComponents];
            
            date = [date nextDay];
        }
        
    }
    
    return componentsArray;
}

- (NSArray *)dateComponentsYearArrayBetweenDate:(NSDate *)endDate
{
    NSArray *array = [self dateComponentsMonthArrayBetweenDate:endDate];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:1];
    
    NSMutableArray *lastMonths = nil;
    
    SCCalendarMonth *lastMonth = nil;
    
    NSInteger count = array.count;
    
    for (NSInteger i = 0; i<count; i++) {
       
        SCCalendarMonth *month = array[i];
            
        if (lastMonth.year!=month.year) {
            
            NSMutableArray *newMonth = [NSMutableArray arrayWithCapacity:12];
            
            SCCalendarYear *newYear = [[SCCalendarYear alloc]init];
            newYear.year = month.year;
            newYear.months = newMonth;
            
            [arrayM addObject:newYear];
            
            lastMonths = newMonth;
            
        }
        
        [lastMonths addObject:month];
        
        lastMonth = month;
    }
    
    return arrayM.copy;
}
- (NSArray *)dateComponentsMonthArrayBetweenDate:(NSDate *)endDate
{

    NSArray *array = [self dateComponentsDayArrayBetweenDate:endDate];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:1];
    
    NSMutableArray *lastDays = nil;
    
    SCCalendarDay *lastDay = nil;
    
    NSInteger count = array.count;
    
    for (NSInteger i = 0; i<count; i++) {
        
        SCCalendarDay *day = array[i];
        
        if (lastDay.month != day.month){
            
            NSMutableArray *newDays = [NSMutableArray arrayWithCapacity:30];
            
            SCCalendarMonth *newMonth = [SCCalendarMonth mj_objectWithKeyValues:day.mj_keyValues];
            newMonth.days = newDays;
            
            [arrayM addObject:newMonth];
            
            lastDays = newDays;
            
        }
        
        [lastDays addObject:day];
        
        lastDay = day;
    }
    
    return arrayM.copy;

}

- (NSArray *)dateComponentsDayArrayBetweenDate:(NSDate *)endDate
{
    
    NSArray *array = [self dateComponentsBetweenDate:endDate];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:1];
    
    NSInteger count = array.count;
    
    for (NSInteger i = 0; i<count; i++) {
        
        NSDateComponents *components = array[i];
        
        NSMutableArray *newHours = [NSMutableArray arrayWithCapacity:24];
        
        SCCalendarDay *newDay = [SCCalendarDay mj_objectWithKeyValues:components.mj_keyValues];
        newDay.hours = newHours;

        [arrayM addObject:newDay];
        
        NSInteger timeInterval = 10;
        NSInteger totalCount = (60/timeInterval);
        
        
        if (i == 0) {
            
            for (NSInteger j = components.hour; j<24; j++) {
                
                SCCalendarHour *newHour = [[SCCalendarHour alloc]init];
                NSMutableArray *minutes = [NSMutableArray arrayWithCapacity:totalCount];
                
                if (j == components.hour) {
                    
                    NSInteger count = components.minute/timeInterval + 1;
                    
                    for (NSInteger k = count; k<totalCount; k++) {
                        
                        [minutes addObject:@(k*timeInterval)];
                        
                    }
                    
                    if (!minutes.count) {
                        
                        continue;
                    }
                    
                }else{
                    
                    for (NSInteger k = 0; k<totalCount; k++) {
                        
                        [minutes addObject:@(k*timeInterval)];
                        
                    }
                    
                }
                
                
                newHour.hour = j;
                newHour.minutes = minutes;
                
                [newHours addObject:newHour];
            }
            
            
        }else if (i==count-1){
            
            for (NSInteger j = 0; j<=components.hour; j++) {
                
                SCCalendarHour *newHour = [[SCCalendarHour alloc]init];
                NSMutableArray *minutes = [NSMutableArray arrayWithCapacity:totalCount];
                
                if (j==components.hour) {
                    
                    NSInteger count = components.minute/timeInterval;
                    
                    for (NSInteger k = 0; k<count; k++) {
                        
                        [minutes addObject:@(k*timeInterval)];
                        
                    }
                    
                    if (!minutes.count) {
                        
                        continue;
                    }
                    
                }else{
                    
                    for (NSInteger k = 0; k<totalCount; k++) {
                        
                        [minutes addObject:@(k*timeInterval)];
                        
                    }
                    
                }
                
                newHour.hour = j;
                newHour.minutes = minutes;
                
                [newHours addObject:newHour];
            }
            
            
        }else{
            
            for (NSInteger j = 0; j<24; j++) {
                
                SCCalendarHour *newHour = [[SCCalendarHour alloc]init];
                NSMutableArray *minutes = [NSMutableArray arrayWithCapacity:totalCount];
                
                for (NSInteger k = 0; k<totalCount; k++) {
                    
                    [minutes addObject:@(k*timeInterval)];
                    
                }
                
                [newHours addObject:newHour];
                
                newHour.hour = j;
                newHour.minutes = minutes;
            }
            
        }
        
    }
    
    return arrayM.copy;
    
}

@end

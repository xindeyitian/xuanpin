//
//  NSDate+SCCommon.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/1/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSDate+SCCommon.h"

@implementation NSDate (SCCommon)

- (NSString *)flightStringHHMM
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"HH:mm";
    
    NSString *dateString = [dateFormatter stringFromDate:self];
    
    return dateString;
}

- (NSString *)stringYYMMDD
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateString = [dateFormatter stringFromDate:self];
    
    return dateString;
}

- (NSString *)stringMMDDHHMM
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"MM-dd HH:mm";
    
    NSString *dateString = [dateFormatter stringFromDate:self];
    
    return dateString;
}

- (NSString *)stringYYMMDDHHMM
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm";
    
    NSString *dateString = [dateFormatter stringFromDate:self];
    
    return dateString;
}

- (NSString *)stringYYMMDDHHMMSS
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    
    NSString *dateString = [dateFormatter stringFromDate:self];
    
    return dateString;
}
@end

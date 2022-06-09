//
//  NSDateComponents+SCCalendar.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/4/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSDateComponents+SCCalendar.h"

@implementation NSDateComponents (SCCalendar)

- (NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = [calendar dateFromComponents:self];
    
    return date;
}
@end

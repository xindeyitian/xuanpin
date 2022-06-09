//
//  SCCalendarMonth.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/4/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SCCalendarMonth.h"

@implementation SCCalendarMonth


+ (NSDictionary *)mj_objectClassInArray
{

    return @{
             @"days":[SCCalendarDay class]
             };
}
@end

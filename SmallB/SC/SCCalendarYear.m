//
//  SCCalendarYear.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/4/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SCCalendarYear.h"

@implementation SCCalendarYear


+ (NSDictionary *)mj_objectClassInArray
{

    return @{
             @"months":[SCCalendarMonth class]
             };
}
@end

//
//  SCCalendarYear.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/4/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "THBaseModel.h"
#import "SCCalendarMonth.h"

@interface SCCalendarYear : THBaseModel


/**
 年
 */
@property(nonatomic,assign) NSInteger year;


/**
 月数组SCCalendarMonth
 */
@property(nonatomic,strong) NSMutableArray *months;

@end

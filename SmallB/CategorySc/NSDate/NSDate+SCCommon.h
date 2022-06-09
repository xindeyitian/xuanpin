//
//  NSDate+SCCommon.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/1/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SCCommon)


/**
 2017-1-1 00：00：00

 @return 时间格式化字符串
 */
- (NSString *)stringYYMMDDHHMMSS;


/**
 2017-1-1 00：00

 @return 时间格式化字符串
 */
- (NSString *)stringYYMMDDHHMM;

/**
 1-1 00：00
 
 @return 时间格式化字符串
 */
- (NSString *)stringMMDDHHMM;


/**
 2017-1-1

 @return 时间格式化字符串
 */
- (NSString *)stringYYMMDD;


/**
 14:00
 
 @return 时间格式化字符串
 */
- (NSString *)flightStringHHMM;

@end

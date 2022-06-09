//
//  NSNumber+SCCommon.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/2/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (SCCommon)

/**
 倒计时

 @return 时间格式 ：：
 */
- (NSString *)timeString;


/**
 耗时

 @return 格式 分钟 小时
 */
- (NSString *)durationString;

/**
 距离

@return  公里
*/
- (NSString *)distanceKilometreString;

/**
 距离

 @return 米 公里
 */
- (NSString *)distanceString;
@end

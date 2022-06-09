//
//  UILabel+SCCommon.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/3/14.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SCCommon)

/**
 *  改变行间距
 */
- (void)changeLineSpace:(float)space;

/**
 *  改变字间距
 */
- (void)changeWordSpace:(float)space;

/**
 *  改变行间距和字间距
 */
- (void)changeLineSpace:(float)lineSpace wordSpace:(float)wordSpace;


@end

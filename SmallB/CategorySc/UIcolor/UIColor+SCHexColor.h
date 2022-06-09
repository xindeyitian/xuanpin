//
//  UIColor+SCHexColor.h
//  LDSpecialCarService
//
//  Created by mac on 2017/2/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SCHexColor)
// iphone/ipad不支持十六进制的颜色表示，对UIColor进行扩展
// 将十六进制颜色的字符串转化为复合iphone/ipad的颜色
// 字符串为"FFFFFF" 必须是6个字符串！！！！！！！！！！
+ (UIColor *)hexChangeFloat:(NSString *) hexColor;

#pragma mark ----- 颜色RGB 输入颜色的值即可返回颜色  范围 0.0 ~ 255.0
+ (UIColor *)ColorNumberR:(CGFloat) R  G: (CGFloat) G   B: (CGFloat) B ;

+ (UIColor *)hexChangeFloat:(NSString *) hexColor Alpha:(CGFloat )alpha;

+ (UIColor *)hexChange:(NSInteger)hexColor;
@end

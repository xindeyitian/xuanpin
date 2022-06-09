//
//  UIColor+Extension.h
//  SaleTool
//
//  Created by Edward on 15/4/10.
//  Copyright (c) 2015年 Yonyouup Information Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Color(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorFromRGBValue(rgbValue)  \
        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                        green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                        blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWith255Red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
@end

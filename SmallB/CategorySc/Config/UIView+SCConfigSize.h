//
//  UIView+SCConfigSize.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/3/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCConfigSize)

+ (CGFloat)tipTableViewCellHeight;

+ (CGFloat)tableViewCellHeight;

+ (CGFloat)buttonMainHeight;

+ (CGFloat)borderWidth;

+ (CGFloat)cornerRadius5;

+ (CGFloat)cornerRadius8;


/**
 内边距

 @return 边距
 */
+ (CGFloat)marginX;

+ (CGFloat)marginY;


/**
 外边距

 @return 边距
 */
+ (CGFloat)outMarginX;

+ (CGFloat)outMarginY;

+ (CGFloat)outMarginBottom;

+ (CGFloat)outMarginRight;
@end

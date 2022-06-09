//
//  UILabel+Create.h
//  JSViewTool
//
//  Created by 张金山 on 2019/12/8.
//  Copyright © 2019 张金山. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
UILabel创建
*/
@interface UILabel (CJCreate)

/**
类方法创建UILabel

@param  frame  frame
@param  title  标题
@param  textColor  标题颜色
@param  textAlignment  文字对其方式
@param  font  字体
@param  backGroundColor  背景颜色
*/
+ (UILabel *)creatLabelWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor;

/**
类方法创建UILabel

@param  title  标题
@param  textColor  标题颜色
@param  textAlignment  文字对其方式
@param  font  字体
*/
+ (UILabel *)creatLabelWithTitle:(NSString *)title textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font;


/**
类方法创建UILabel

@param  title  标题
@param  textColor  标题颜色
@param  textAlignment  文字对其方式
@param  font  字体
@param  backGroundColor  背景颜色
*/
+ (UILabel *)creatLabelWithTitle:(NSString *)title textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor;


@end

NS_ASSUME_NONNULL_END

//
//  UILabel+Create.m
//  JSViewTool
//
//  Created by 张金山 on 2019/12/8.
//  Copyright © 2019 张金山. All rights reserved.
//

#import "UILabel+CJCreate.h"

@implementation UILabel (CJCreate)

/**
类方法创建UIButton

@param  frame  frame
@param  title  标题
@param  textColor  标题颜色
@param  textAlignment  文字对其方式
@param  font  字体
@param  backGroundColor  背景颜色
*/
+ (UILabel *)creatLabelWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    if(title) {
        label.text = title;
    }
    if(textColor) {
        label.textColor = textColor;
    }
    if(textAlignment) {
        label.textAlignment = textAlignment;
    }
    if(font) {
        label.font = font;
    }
    if(backGroundColor) {
        label.backgroundColor = backGroundColor;
    }
    return label;
}

/**
类方法创建UIButton

@param  title  标题
@param  textColor  标题颜色
@param  textAlignment  文字对其方式
@param  font  字体
*/
+ (UILabel *)creatLabelWithTitle:(NSString *)title textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font {
    return [self creatLabelWithFrame:CGRectZero title:title textColor:textColor textAlignment:textAlignment font:font backGroundColor:[UIColor clearColor]];
}

/**
类方法创建UILabel

@param  title  标题
@param  textColor  标题颜色
@param  textAlignment  文字对其方式
@param  font  字体
@param  backGroundColor  背景颜色
*/
+ (UILabel *)creatLabelWithTitle:(NSString *)title textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor {
    return [self creatLabelWithFrame:CGRectZero title:title textColor:textColor textAlignment:textAlignment font:font backGroundColor:backGroundColor];
}


@end

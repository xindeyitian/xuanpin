//
//  NSString+AttributedString.h
//  Present
//
//  Created by liu_cong on 16/8/26.
//  Copyright © 2016年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>


@interface NSString (AttributedString)

/**
 *  将调用此方法的字符串转变为富文本字符串 然后改变一句话中的某些字的颜色
 *
 *  @param color    需要改变成的颜色
 *  @param subArray 总的字符串
 *
 *  @return 生成的富文本
 */
-(NSMutableAttributedString *)changeColorWithColor:(UIColor *)color SubStringArray:(NSArray *)subArray;

/**
 *  改变调用此字符串的字间距
 *
 *  @param space 字间距
 *
 *  @return 生成的富文本
 */
-(NSMutableAttributedString *)changeSpace:(CGFloat)space;

/**
 *  改变调用此字符串的行间距
 *
 *  @param lineSpace 行间距
 *
 *  @return 生成的富文本
 */
-(NSMutableAttributedString *)changeLineSpaceWithLineSpace:(CGFloat)lineSpace;

/**
 *  改变调用此字符串的行间距   字间距
 *
 *  @param lineSpace 行间距
 *  @param textSpace 字间距
 *
 *  @return 生成的富文本
 */
-(NSMutableAttributedString *)changeLineAndTextSpaceWithLineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;

/**
 *  改变某些文字的颜色 并单独设置其字体
 *

 */
-(NSMutableAttributedString *)changeFontAndColor:(UIFont *)font Color:(UIColor *)color SubStringArray:(NSArray *)subArray;

//相比上一个增加初始化字体大小和颜色
-(NSMutableAttributedString *)InitFont:(UIFont *)initFont  InitColor: (UIColor *)initColor    changeFontAndColor:(UIFont *)font Color:(UIColor *)color SubStringArray:(NSArray *)subArray;


@end

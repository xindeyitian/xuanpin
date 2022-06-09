//
//  NSString+Common.h
//  TaxiDriver
//
//  Created by Mac on 16/8/19.
//  Copyright © 2016年 ShouYueTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString (SCCommon)

//手机号验证
- (BOOL)isPhoneNumber;

/**
 根据逗号分割字符串 获取第一个 id 的字符串
 
 @return  第一个id 的字符串
 */
- (NSString *)getFirstStr;

/**
 找到联系方式

 @return 联系方式数组
 */
- (NSArray *)regularPhone;


//Email验证
- (BOOL)isEmail;

//是否都为空格
- (BOOL)isAllSpaceText;

//UTF8转码
- (NSString *)NSUTF8StringEncoding;

//MD5加密
- (NSString *)md5Str;

- (NSString*)sha1Str;

//NSString转NSData
- (NSData *)convertToData;

/**
 *  计算文字大小
 */
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  计算当前时间与订单生成时间的时间差，转化成分钟
 */
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime;

/**
 *  时间戳转日期
 *
 *  @return yyyy年MM月dd日
 */
- (NSString *)timestampToTimeStr;


/**
 航班定制日期字符串转日期
 2017-03-17 09:05:00
 @return 时间戳
 */
- (NSDate *)flightCustomDateStrToDate;

/// 获取当前时间戳
- (NSString *)currentTimeStr;
/**
 *  判断是否为整形
 */
- (BOOL)isInt;

/**
 *  判断是否为浮点形
 */
- (BOOL)isFloat;

/**
 *  返回自己的range
 */
-(NSRange)rangeOfAll;


/**
 转化为json对象

 @return 对象 数组 字典
 */
- (id)JSONObject;

#pragma mark ----- UILable 文字转化成对应的Frame 在TableView 计算文字Lable高度和宽度常用
//通过UITextView计算高度
- (CGSize)rectWithFontSize:(CGFloat)fontSize width:(CGFloat)width;
- (CGRect)stringRectWithfontSize:(CGFloat)fontSize contentSize:(CGSize)size;
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;
- (CGSize)sizeWithLabelHeight:(CGFloat)height font:(UIFont *)font;
/**
 字符串转成富文本

 @param textColor 字体颜色
 @return 富文本
 */
- (NSMutableAttributedString *)attributedStringTextColor:(UIColor *)textColor;


/**
 富文本 - 颜色

 @param textColor 文字颜色
 @param range range
 @return 富文本
 */
- (NSMutableAttributedString *)attributedStringTextColor:(UIColor *)textColor range:(NSRange)range;
/**
 富文本文件 改变文字颜色
 rangeArray个数为准
 @param textColorArray 颜色数组
 @param rangeArray range数组 格式为字符串 @",";
 @return 富文本文件
 */
- (NSMutableAttributedString *)attributedStringTextColorArray:(NSArray *)textColorArray rangeArray:(NSArray *)rangeArray;

- (NSMutableAttributedString *)attributedStringTextFont:(UIFont *)textFont;

- (NSMutableAttributedString *)attributedStringLink:(NSURL *)link;

- (NSMutableAttributedString *)attributedStringHTMLText;

- (NSString *)HTMLColor:(NSString *)textHexColor;

#pragma mark 检查车牌号
- (BOOL)checkCarID;

/**
 检测字符串是否为nil 或者是空字符串@""

 @return YES 是空字符串
 */
- (BOOL)isEmptyAndNil;


/**
 获取32位UUID

 @return32位UUID
 */
+(NSString*)getUuid;


/**
 * 验证身份证号，只能输入数字、“X”和“x”，共18个字符
 */
- (BOOL)validateIdCard;
/**
 * 验证护照号，只能输入"G加8位数字"或"E加8位数字"，共9个字符
 */
- (BOOL)validatePassportCard;
/**
 * 验证港澳通行证号，只能输入"W加8位数字"或"C加8位数字"，共9个字符
 */
- (BOOL)validateGangAoPassportNumber;

- (BOOL)PassWordLimt;
/**
 * 验证银行卡是否合法
 */
- (BOOL)checkBankCardNumber;


- (NSArray *)regularkuohao;

/**
 时间转换
 @param time 时间的秒数
 @return 时间字符串
 */
+(NSString *)convertStringWithTime:(float)time;


- (NSArray *)regularkuohao1;
- (NSArray *)regularkuohao2;

@end

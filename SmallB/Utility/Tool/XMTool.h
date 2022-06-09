//
//  XMTool.h
//  HKMedia
//
//  Created by 杨晓铭 on 2018/9/21.
//  Copyright © 2018年 杨晓铭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMTool : NSObject
/** 字符串取颜色 */
+ (UIColor *)ColorWithColorStr:(NSString *)colorStr;
/** 随机颜色 */
+(UIColor*)color:(NSInteger)idx;
/** 获取机器mac地址 */
+ (NSString *)getUUIDString;

/** 获取机器UUID */
+(NSString*) GetIOSUUID;


/** 获取机器信息 */
+(NSDictionary*) GetPhoneMessage;

/** 获取设备推送 deviceToken */
+ (NSString *)getDeviceToken;

/** 删除NSUserDefaults所有记录 */
+ (void)removeUserDefaultsRecords;

/** 使用正则表达式去掉html中的标签元素,获得纯文本 */
+ (NSMutableArray *)regularExpretionWithHtmlStr:(NSString *)htmlStr;

+ (void)showAlertViewWithStr:(NSString *)str;
//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;

/** 判断银行卡 */
+ (BOOL)checkCardNo:(NSString*)cardNo;

/** 邮箱格式是否正确 */
+ (BOOL)emailIsLegal:(NSString *)email;

/** 是否是包含数字 */
+ (BOOL) deptNumInputShouldNumber:(NSString *)str;

/** 用户名格式是否正确 */
+ (BOOL) UserNameIsLegal:(NSString *)name;

/** 手机格式是否正确 */
+ (BOOL)phoneNumberIsLegal:(NSString *)mobile;

/** 固定电话格式是否正确 */
+ (BOOL)telephoneNumberIsLegal:(NSString *)number;

/** 身份证格式是否正确 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/** 注册密码格式是否正确 */
+ (BOOL)passwordIsLegal:(NSString *)password;

/** string是否为空 */
+ (BOOL)strIsEmpty:(NSString *)str;

/** 字符串是否有效   YES 合法的值  NO 不合法 */
+ (BOOL)strExistence:(NSString *)string;

/** 禁止表情输入 */
+ (BOOL)isContainsEmoji:(NSString *)string;

/** cookie */
+ (void)addCookie:(NSString *)session;

/** 把十六进制颜色值转化  参数:十六进制颜色值 */
+ (UIColor *)colorWithString:(NSString *)hexColor alpha:(CGFloat)alpha;

/** 把十六进制颜色值转化  参数:十六进制颜色值 */
+ (UIColor *)colorWithString:(NSString *)hexColor;

/** label高度自适应  参数: 文本text,字体,label的宽度 */
+ (CGFloat)heightOfLabel:(NSString *)strText forFont:(UIFont *)font labelLength:(CGFloat)length;

/** label宽度自适应  */
+ (CGFloat)widthOfLabel:(NSString *)strText ForFont:(UIFont *)font labelHeight:(CGFloat)height;

/** label显示html格式(attributedText) */
+ (NSAttributedString *)changeWithHtmlStr:(NSString *)str;

/** 获取当前时间 */
+ (NSString *)getCurrentTime;

/** 日期转化星期 */
+ (NSString *)getWeekFromDateWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

/** 格式化的JSON格式的字符串转换字典 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr;



/** 取图片 */
+ (UIImage *)imageWithName:(NSString *)imageName;

/** 绘制UIImage */
+ (UIImage *)captureView:(UIView *)theView;

/** 截取部分图像 */
+ (UIImage *)getSubImage:(CGRect)rect withImage:(UIImage *)image;

/** 图片等比例缩放 */
+ (UIImage *)scaleToSize:(CGSize)size withImage:(UIImage *)image;

/** 图片截取 */
+ (UIImage *)cutOutNewImage:(UIImage *)originalImage withScale:(CGFloat)scale;

/**按最短边 等比压缩 */
+(UIImage*)imageWithImage:(UIImage *)image ratioCompressToSize:(CGSize)newSize;

/** wifiIP */
+ (NSString *) localWiFiIPAddress;

/** 计算缓存大小 */
+ (float)folderSizeAtPath:(NSString *)folderPath;

/** 用户ID转环信ID */
+ (NSString *)EasemoIdbyUserId:(NSString *)userId;

/** 环信ID转用户ID */
+ (NSString *)UserIDbyEasemoId:(NSString *)easemoId;

/** 用户ID组转环信ID组 */
+ (NSArray *)EasemoIdArrybyUserId:(NSArray *)userIdArry;

/** 环信ID组转用户ID组 */
+ (NSArray *)UserIDArrybyEasemoId:(NSArray *)easemoIdArry;

/** 字符串转十六进制 */
+ (NSData *)convertHexStrToData:(NSString *)str;

/** 十六进制转字符串 */
+ (NSString *)convertDataToHexStr:(NSData *)data;

/** 字典去NULL */

+ (NSDictionary *)dictionaryWithDictRemoveNull:(NSDictionary *)dict;

/** 数组去NULL */

+ (NSArray  *)arryWithArryRemoveNull:(NSArray *)arry;


/** 提示框 */
+ (void)showHUDWithStr:(NSString *)str;

+ (void)showLoadingWith:(UIView *)view showText:(NSString *)showText;

+ (void)hideLoadHUDWith:(UIView *)view;

/** 日期比较 */
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;

/** 时间比较 */
+ (NSInteger)compareTime:(NSString*)aTime withTime:(NSString*)bTime;

/** 字符限制 */
+ (NSString *)textFiledEditChangedWith:(UITextField *)textField MaxLength:(NSInteger)kMaxLength;

/** 判断是否开启推送 */
+ (BOOL)isAllowedNotification;

/** 数组转json字符串*/
+ (NSString *)arrayToJSONString:(NSMutableArray *)array;

/** 把多个json字符串转为一个json字符串*/
+ (NSString *)objArrayToJSON:(NSMutableArray *)array;

/** 字典转json格式字符串*/
+ (NSString*)dictionaryToJson:(NSMutableDictionary *)dic;

/** 判断当前控制器是否正在显示 */
+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

/** Label显示不同样式 */
+ (NSMutableAttributedString *)labelWithText:(NSString *)text Color:(UIColor *)color Font:(UIFont *)font range:(NSRange)range;

/** 颜色渐变 */
+ (CAGradientLayer *)gradientWithColorsArr:(NSArray *)colorsArr frame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/** 制作图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/** 图片旋转处理 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/** 剪切字符串转字典 */
+ (NSDictionary *)DictFromStrCut:(NSString*)Str Action:(NSString*)action;

/** 获取顶层viewController */
+ (UIViewController *)topViewController;

/** 判断字符串是否为URL */
+ (BOOL)urlValidation:(NSString *)string;

/** 压缩图片到指定文件大小 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)maxLength;

/** 压缩图片 */
+ (NSData *)zipNSDataWithImage:(UIImage *)sourceImage;

// 判断用户是否允许接收通知
+ (BOOL)isUserNotificationEnable;

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
+ (void)goToAppSystemSetting;

//适配暗夜模式颜色
+ (UIColor *)bGviewBackgroudColor;
@end

NS_ASSUME_NONNULL_END

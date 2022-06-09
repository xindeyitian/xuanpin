//
//  DHCCToolsMethod.h
//  MobileBanking
//
//  Created by wuzhao on 16/8/15.
//  Copyright © 2016年 dhcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHCCToolsMethod : NSObject
//字典 通过value找key

+(NSString *)keyForValueWithDic:(NSDictionary *)dic andValue:(NSString *)value;

// 弹出提示框
+ (void)alertMessage:(NSString *)message vc:(UIViewController *)vc;

// 弹出提示框，message居左
+ (void)alertMessageLeftWithMessage:(NSString *)message vc:(UIViewController *)vc;

//非空校验
+(Boolean)IsNil:(NSString *)value;
/** 获取当前时间 */
+ (NSString *)getCurrentDateTime;
/** 获取当前日期 */
+ (NSString *)getCurrentDate;
/**获取当前日期前day天的日期 */
+ (NSString *)getDateFrontDay:(NSInteger)day;


/**20170309格式化为2017年03月09日*/
+ (NSString *)dateStrFormaterDate:(NSString *)dateStr;
/**20170309格式化为2017.03.09*/
+ (NSString *)dateStrFormaterDate:(NSString *)dateStr withFormart:(NSString*)formart;
/**2017.03.09格式化为20170309*/
+ (NSString *)strFormaterDate:(NSString *)dateStr withFormart:(NSString*)formart;
/**20170309-20170309格式化为2017.03.09-2027.03.09*/
+ (NSString *)strFormaterDateStr:(NSString *)dateStr withFormart:(NSString*)formart;
/**2017.03.09-2027.03.09格式化为20170309-20170309*/
+ (NSString *)dateFormaterStr:(NSString *)dateStr withFormart:(NSString*)formart;

/** 日期合法的校验 */
+ (BOOL)validateDate:(NSString *)value;

//校验身份证号码
+ (BOOL)validateIDCardNumber:(NSString *)value;

// 校验用户名
+ (BOOL)validateUserName:(NSString *)userName;

// 校验密码
+ (BOOL)validatePassword:(NSString *)passWord;

/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
+ (BOOL) validateBankCardNumber:(NSString *)cardNum;

// 校验邮箱
+ (BOOL) validateEmail:(NSString *)email;

// 校验手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

// 手机号加密  15339255159  --> 153****5159
+ (NSString *)phoneFromPhoneString:(NSString *)phone;

// 合同号  123456789  --> 1234****6789
+ (NSString *)cont_noFromCont_no:(NSString *)cont_no;

// 身份证号加密  412724197103192930  --> 4127******2930
+ (NSString *)certFromCert:(NSString *)cert;

/** 检验6-16位密码字母数字组合*/
+ (BOOL)checkPassword:(NSString *) password;

// 弹出拍照sheet
+ (void)addAlumByController:(UIViewController *)controller indexPath:(NSIndexPath*)indexPath;
+ (void)addAlumByController:(UIViewController *)controller delegate:(id)delegage;

/** 金额输入限制
 1.要求用户输入首位不能为小数点;
 2.小数点后不超过两位，小数点无法输入超过一个;
 3.如果首位为0，后面仅能输入小数点
 4.输入金额不超过10位(整数金额)
 这个输入首位不能为0时，可以在限制首位不能为“.”的地方加上，可以根据自己需要修改.
 */
+ (BOOL)formatMoneyWithTextField:(UITextField *)textField range:(NSRange)range replacementString:(NSString *)string;
/** 金额加逗号 ‘,’  */
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString;
/** 金额去除逗号 "," */
+ (NSString *)amountToRemoveCommas:(NSString *)string;
/** 小写金额转化为大写金额 */
+ (NSString *)changetochinese:(NSString *)numstr;

/**
    银行卡加空格
    添加空格，每4位之后，4组之后不加空格，格式为xxxx xxxx xxxx xxxx xxx
 */
+ (BOOL)formatBankCardNoWithTextField:(UITextField *)textField range:(NSRange)range replacementString:(NSString *)string;
/** 去除空格 */
+ (NSString *)amountToRemoveSpace :(NSString *)string;

+(NSString *)imageTurnToBase64:(UIImage *)image;

//字符串加空格格式为xxxx xxxx xxxx xxxx xxx
+(NSString*)formatBankCardNo:(NSString *)string;

//金额小写转大写
+(NSString *)digitUppercase:(NSString *)money;
+(NSString *)toCapitalLetters:(NSString *)money;
//tabelView多余分割线
+(void)setExtraCellLineHidden: (UITableView *)tableView;
#pragma mark - float校验
+(BOOL)isPureFloat:(NSString*)string;
//计算两个时间之间的天数
+(NSString *)calculatorDayfromStartDate:(NSString *)startDateStr endDate:(NSString *)endDateStr;
//字符串转date
+(NSDate *)StringTODate:(NSString *)sender;
//登陆返回数据保存处理
+(void)returnDate:(NSMutableDictionary *)responseData;
// 逗号(.)分离年月日
+ (NSString *)seperateTimeWithPoint:(NSString *)timeString;
//时间戳转时间
+(NSString *)timestampSwitchTime:(NSString *)timestamp;

//截取字符串后四位
+(NSString *)subStrtoLastFour:(NSString *)str;

//截取字符串前五位
+ (NSString *)subFrontFour:(NSString *)str;
//截取从二到结束
+ (NSString *)subTwoToLast:(NSString *)str;
//截取首字母
+ (NSString *)subFrontOne:(NSString *)str;
//移除nav中的控制器
+ (void)removeNavToCotroller:(NSString *)VCName Nav:(UINavigationController *)nav;

//跳转到控制器
+(void)ToOneController:(NSString *)VCName Nav:(UINavigationController *)nav;

#pragma mark - 升序排序
+ (NSMutableArray *)sortArrayAscendingWithArray:(NSMutableArray *)prdtArray dictKey:(NSString *)key;
#pragma mark - 降序排序
+ (NSMutableArray *)sortArrayDescendingWithArray:(NSMutableArray *)prdtArray dictKey:(NSString *)key;

#pragma mark - 身份证加空格  开头6个加空格 后面4个加空格  610126 19900213 4337
+ (BOOL)formatCertNoWithTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
#pragma mark - 手机号加空格  开头3个加空格 后面4个加空格  153 3925 5159
+ (BOOL)formatPhoneNoWithTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
#pragma mark - 根据身份证号码获取性别
+ (NSString *)sexStrFromIdentityCard:(NSString *)numberStr;
//获得16位的随机数作为AES加密秘钥
+ (NSString *)getRandomKey;
//字典转string
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
//去空格
+ (NSString *)deleteStr:(NSString *)string;

#pragma mark - 加空格 222222222222012  --> 2222 2222 2222 012
+ (NSString *)formartFromString:(NSString *)str;
#pragma mark --银行卡号加密  412724197103192930  --> 4127******2930
+ (NSString *)bankNoForCert:(NSString *)cert;
#pragma mark --银行卡号加密  412724197103192930  --> **** *** ****2930
+ (NSString *)bankNoForCert2:(NSString *)cert;
#pragma mark --银行卡号加密  412724197103192930  --> **** **** **** 3192 930
+ (NSString *)bankNoForCert3:(NSString *)cert;

+ (NSString *)userNameFromString:(NSString *)name;

+ (NSString *)acountFinalNumString:(NSString *)account;

#pragma mark - 给输入框添加逗号
+ (NSString *)formarText:(NSString*)text withString:(NSString*)string;

// == 秦氏添加逗号大法
+ (NSString *)addCharForString:(NSString *)str textFiled:(UITextField *)textFiled;

@end

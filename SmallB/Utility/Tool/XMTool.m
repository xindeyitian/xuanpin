//
//  XMTool.m
//  HKMedia
//
//  Created by 杨晓铭 on 2018/9/21.
//  Copyright © 2018年 杨晓铭. All rights reserved.
//

#import "XMTool.h"
#import "DefineUtils.h"
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#import <dlfcn.h>
#import <CoreText/CoreText.h>
//#import "SFHFKeychainUtils.h"
#import "JSON+Helpers.h"
#import "sys/utsname.h"

@implementation XMTool

/** 字符串取颜色 */
+ (UIColor *)ColorWithColorStr:(NSString *)colorStr{
    unsigned long color = strtoul([colorStr UTF8String],0,16);
    
    UIColor * themeColor=UIColorFromHEX(color);
    
    return themeColor;
    
}
+(UIColor*)color:(NSInteger)idx
{
    //执行颜色数组：
   static  unsigned char colors[][3] = {
        {0xED,0xED,0xED},   //0
        {0xFE,0xCE,0xA8},   //1
        {0xFF,0x84,0x7C},   //2
        {0xE8,0x4a,0x5f},   //3
        {0x2a,0x36,0x3b},   //4
        {0x87,0xce,0xbe},   //5
        {0x87,0xce,0xfa},   //6
        {0x00,0xbf,0xff},   //7
        {0xb0,0xe0,0xe6},   //8
        {0x1e,0x90,0xff},   //9
        {0xa6,0xf6,0xc1},   //10
        {0x31,0xa2,0x9d},   //11
        {0x4c,0x64,0x88},   //12
        {0x60,0x34,0x6e},   //13
        {0xf8,0xe7,0x9c},   //14
        {0x65,0x97,0xbc}    //15
    };
    
    return [UIColor colorWithRed:colors[idx][0]/255.0 green:colors[idx][1]/255.0 blue:colors[idx][2]/255.0 alpha:1];
}

/** 获取机器信息 */
+(NSDictionary*) GetPhoneMessage{
    
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    
    NSLog(@"%@",infoDict);
    
    return infoDict;
}

/** 获取机器mac地址 */
+ (NSString *)getUUIDString
{
    
    //    NSString *macAddress = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //    macAddress = [[macAddress componentsSeparatedByString:@"-"] componentsJoinedByString:@""];
    
    //    [SFHFKeychainUtils storeUsername:@"UDID" andPassword:[macAddress forServiceName:@"ZYY" updateExisting:1 error:nil];
    
    
    
    return [self GetIOSUUID];
}

+(NSString*) GetIOSUUID

{
//deleteItemForUsername
//    NSError *error;
//
//    NSString * string = [SFHFKeychainUtils storeUsername:@"UUID" andServiceName: @"com.china.TestKeyChain" error:&error];
//
//    if (!string) {
//
//    }
//
//    if(error || !string){
//        NSLog(@"❌从Keychain里获取密码出错：%@", error);
//        [self saveUUID];//保存
//        string = [SFHFKeychainUtils getPasswordForUsername:@"UUID" andServiceName: @"com.china.TestKeyChain" error:&error];
//
//    }
//    else{
//        NSLog(@"✅从Keychain里获取密码成功！密码为%@",string);
//    }
//    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    return string;
//
    return nil;
}
//     保存uuid方法（此方法不必自己调用）

+(void)saveUUID
{
    
//    CFUUIDRef puuid = CFUUIDCreate( nil );
//    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
//    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
//    CFRelease(puuid);
//    CFRelease(uuidString);
//
//    NSError *error;
//
//    BOOL saved = [SFHFKeychainUtils storeUsername:@"UUID" andPassword:result
//                                   forServiceName:@"com.china.TestKeyChain" updateExisting:YES error:&error];
//
//    if (!saved) {
//        NSLog(@"❌Keychain保存密码时出错：%@", error);
//    }else{
//        NSLog(@"✅Keychain保存密码成功！%@",result);
//    }
    
    
    
}
/** 获取设备推送 deviceToken */
+ (NSString *)getDeviceToken
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"kDeviceToken"];
    if ([self strExistence:str]) {
        return str;
    }
    else {
        return @"";
    }
}

/** 删除NSUserDefaults所有记录 */
+ (void)removeUserDefaultsRecords
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults dictionaryRepresentation];  // get all value and key in userDefault
    for (id key in dict) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

/** 使用正则表达式去掉html中的标签元素,获得纯文本 */
+ (NSMutableArray *)regularExpretionWithHtmlStr:(NSString *)htmlStr
{
    NSRegularExpression *regularExpretion =
    [NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                              options:0
                                                error:nil];
    // 替换所有html和换行匹配元素为"-"
    htmlStr = [regularExpretion stringByReplacingMatchesInString:htmlStr
                                                         options:NSMatchingReportProgress
                                                           range:NSMakeRange(0, htmlStr.length)
                                                    withTemplate:@"-"];
    // 把多个"-"匹配为一个"-"
    regularExpretion = [NSRegularExpression regularExpressionWithPattern:@"-{1,}"
                                                                 options:0
                                                                   error:nil];
    htmlStr = [regularExpretion stringByReplacingMatchesInString:htmlStr
                                                         options:NSMatchingReportProgress
                                                           range:NSMakeRange(0, htmlStr.length)
                                                    withTemplate:@"-"];
    // 根据"-"分割到数组
    NSArray *arr = [NSArray array];
    htmlStr = [NSString stringWithString:htmlStr];
    arr = [htmlStr componentsSeparatedByString:@"-"];
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:arr];
    
    return arrM;
}

+ (void)showAlertViewWithStr:(NSString *)str
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


/** cookie */
+ (void)addCookie:(NSString *)session
{
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    [properties setObject:@"" forKey:NSHTTPCookieDomain];
    [properties setObject:@"/" forKey:NSHTTPCookiePath];
    [properties setObject:@"__SESSION_USER_TOKEN" forKey:NSHTTPCookieName];
    [properties setObject:@"" forKey:NSHTTPCookieValue];
    [properties setObject:[[NSDate date] dateByAddingTimeInterval:26297430] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:properties];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [storage setCookie:cookie];
    for (NSHTTPCookie *cookie in storage.cookies) {
        NSLog(@"cookie = %@", cookie);  // check cookie
        [storage deleteCookie:cookie];  // delete cookie
    }
}


/** 注册密码格式是否正确(6-16个字符组成，可使用数字、英文字母、下划线， 密码区分大小写) */
+ (BOOL)passwordIsLegal:(NSString *)password
{
    NSString *Regex = @"^[0-9A-Za-z_]{6,16}$";
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    BOOL bPass = [emailCheck evaluateWithObject:password];
    return bPass;
}
//判断是否为整形：

+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
/** 判断银行卡 */
+ (BOOL)checkCardNo:(NSString*)cardNo{
    
    int oddsum = 0;     //奇数求和
    
    int evensum = 0;    //偶数求和
    
    int allsum = 0;
    
    int cardNoLength = (int)[cardNo length];
    
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    
    for (int i = cardNoLength -1 ; i>=1;i--) {
        
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        
        int tmpVal = [tmpString intValue];
        
        if (cardNoLength % 2 ==1 ) {
            
            if((i % 2) == 0){
                
                tmpVal *= 2;
                
                if(tmpVal>=10)
                    
                    tmpVal -= 9;
                
                evensum += tmpVal;
                
            }else{
                
                oddsum += tmpVal;
                
            }
            
        }else{
            
            if((i % 2) == 1){
                
                tmpVal *= 2;
                
                if(tmpVal>=10)
                    
                    tmpVal -= 9;
                
                evensum += tmpVal;
                
            }else{
                
                oddsum += tmpVal;
                
            }
            
        }
        
    }
    
    
    
    allsum = oddsum + evensum;
    
    allsum += lastNum;
    
    if((allsum % 10) == 0)
        
        return YES;
    
    else
        
        return NO;
    
}
/** 邮箱格式是否正确 */
+ (BOOL)emailIsLegal:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailCheck evaluateWithObject:email];
}
/** 是否是包含数字 */
+ (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}


/** 用户名格式是否正确 */
+ (BOOL) UserNameIsLegal:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{4,16}+$";//6到20位
    NSPredicate *userNameCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", userNameRegex];
    return [userNameCheck evaluateWithObject:name];
    return YES;
}

/** 手机格式是否正确 */
+ (BOOL)phoneNumberIsLegal:(NSString *)mobile
{
    NSString *phoneNumRegex = @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$";
    NSPredicate *mobileCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumRegex];
    return [mobileCheck evaluateWithObject:mobile];
}

/** 固定电话格式是否正确 */
+ (BOOL)telephoneNumberIsLegal:(NSString *)number
{
    //验证输入的固话中不带 "-"符号
    NSString * strNum = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
    //验证输入的固话中带 "-"符号
    //    NSString * strNum =@"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|14[5|7|9]|15[0-9]|17[0|1|3|5|6|7|8]|18[0-9])\\d{8}$)";
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    return [checktest evaluateWithObject:number];
}

// 身份证格式是否正确
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

/** string是否为空 */
+ (BOOL)strIsEmpty:(NSString *)str
{
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceCharacterSet];
    if ([str stringByTrimmingCharactersInSet:whiteSpace].length == 0) {
        return YES;
    }
    return NO;
}

/** 字符串是否有效   YES 合法的值  NO 不合法 */
+ (BOOL)strExistence:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    NSCharacterSet *space = [NSCharacterSet whitespaceCharacterSet];
    
    if (string && [string stringByTrimmingCharactersInSet:space].length > 0) {
        return YES;
    }
    else {
        return NO;
    }
}

/** 禁止表情输入 */
+ (BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

/** 把十六进制颜色值转化  参数:十六进制颜色值 */
+ (UIColor *)colorWithString:(NSString *)hexColor alpha:(CGFloat)alpha
{
    NSAssert(hexColor.length == 6, @"参数 hexColor 长度必须等于6");
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:alpha];

}
/** 把十六进制颜色值转化  参数:十六进制颜色值 */
+ (UIColor *)colorWithString:(NSString *)hexColor
{
    NSAssert(hexColor.length == 6, @"参数 hexColor 长度必须等于6");
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

/** label高度自适应  参数: 文本text,字体,label的宽度 */
+ (CGFloat)heightOfLabel:(NSString *)strText forFont:(UIFont *)font labelLength:(CGFloat)length
{
    CGSize size;
    
    if (kVersion >= 7.0) {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        size = [strText boundingRectWithSize:CGSizeMake(length, 0)
                                     options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attribute
                                     context:nil].size;
    }else {
        size = [strText sizeWithFont:font constrainedToSize:CGSizeMake(length, 10000) lineBreakMode:NSLineBreakByTruncatingTail];
    }
    
    return size.height;
}

/** label宽度自适应  */
+ (CGFloat)widthOfLabel:(NSString *)strText ForFont:(UIFont *)font labelHeight:(CGFloat)height
{
    CGSize size;
    if (kVersion >= 7.0) {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        size = [strText boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else {
        size = [strText sizeWithFont:font];
    }
    
    return size.width;
}

/** label显示html格式*/
+ (NSAttributedString *)changeWithHtmlStr:(NSString *)str;
{
    NSString *htmlStr = str;
    NSData *data = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
    NSMutableAttributedString *attrStr =
    [[NSMutableAttributedString alloc] initWithData:data
                                            options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType
                                                      }
                                 documentAttributes:nil
                                              error:nil];
    [attrStr addAttribute:(NSString *)kCTFontAttributeName
                    value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont systemFontOfSize:13].fontName,
                                                                     13,
                                                                     NULL))
                    range:NSMakeRange(0, attrStr.length)];   // font
    [attrStr addAttribute:(NSString *)kCTForegroundColorAttributeName
                    value:(id)[UIColor lightGrayColor].CGColor
                    range:NSMakeRange(0, attrStr.length)];  // color
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 10.f;
    paragraphStyle.maximumLineHeight = 20.f;
    paragraphStyle.lineHeightMultiple = 1.0f;
    NSDictionary *attributtes = @{NSParagraphStyleAttributeName : paragraphStyle};
    [attrStr addAttributes:attributtes
                     range:NSMakeRange(0, attrStr.length)]; //  设置段落样式
    
    return attrStr;
}

/** 获取当前时间 */
+ (NSString *)getCurrentTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *str = nil;
    str = [formatter stringFromDate:date];
    return str;
}

/** 日期转化星期 */
+ (NSString *)getWeekFromDateWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:[year integerValue]];
    [components setMonth:[month integerValue]];
    [components setDay:[day integerValue]];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [gregorian setTimeZone:timeZone];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    
    NSInteger weekday = [weekdayComponents weekday]-1;
    
    NSString *str = nil;
    switch (weekday) {
        case 1:{
            str = @"星期一";
        }
            break;
        case 2:{
            str = @"星期二";
        }
            break;
        case 3:{
            str = @"星期三";
        }
            break;
        case 4:{
            str = @"星期四";
        }
            break;
        case 5:{
            str = @"星期五";
        }
            break;
        case 6:{
            str = @"星期六";
        }
            break;
        case 0:{
            str = @"星期日";
        }
            break;
        default:
            break;
    }
    
    return str;
}

/** 格式化的JSON格式的字符串转换字典 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr
{
    if (jsonStr == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    // 把数据序列化
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"解析失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.delegate = self;
        [alertView show];
        return nil;
    }
    
    return dict;
}



/** 取图片 */
+ (UIImage *)imageWithName:(NSString *)imageName
{
    NSString *name = [NSString stringWithFormat:@"%@@2x.png", imageName];
    NSString * filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"" inDirectory:nil];
    UIImage* img = [UIImage imageWithContentsOfFile:filePath];
    return img;
}

/** 绘制UIImage */
+ (UIImage *)captureView:(UIView *)theView
{
    CGRect rect = theView.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/** 截取部分图像 */
+ (UIImage *)getSubImage:(CGRect)rect withImage:(UIImage *)image
{
    rect.size.width = rect.size.width * 2;
    rect.size.height = rect.size.height * 2;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

/** 图片旋转处理 */
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage), CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

/** 图片等比例缩放 */
+ (UIImage *)scaleToSize:(CGSize)size withImage:(UIImage *)image
{
    UIImage *scaleImage = nil;
    
    UIImage *img = [XMTool fixOrientation:image];
    scaleImage = [self cutOutNewImage:img withScale:1.0];
    UIGraphicsBeginImageContext(size);
    [scaleImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *transformImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return transformImage;
}

/** 图片截取 */
+ (UIImage *)cutOutNewImage:(UIImage *)originalImage withScale:(CGFloat)scale
{
    //定义myImageRect，截图的区域
    if (!originalImage) {
        return nil;
    }
    
    CGRect myImageRect;
    CGSize size;
    CGFloat orignalHeight = originalImage.size.height;
    CGFloat orignalWidth  = originalImage.size.width;
    
    if (orignalWidth/orignalHeight == scale) {
        return originalImage;
    }
    else if (orignalWidth/orignalHeight > scale) {
        myImageRect = CGRectMake((orignalWidth-orignalHeight*scale)/2, 0, orignalHeight*scale, orignalHeight);
        size.width = orignalHeight * scale;
        size.height = orignalHeight;
    }
    else{
        myImageRect = CGRectMake(0, 0, orignalWidth, orignalWidth/scale);
        size.width = orignalWidth;
        size.height = orignalWidth/scale;
    }
    CGImageRef imageRef = originalImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return smallImage;
}

/* 按最短边 等比压缩 */
+(UIImage *)imageWithImage:(UIImage *)image ratioCompressToSize:(CGSize)newSize
{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    if(width < newSize.width && height < newSize.height)
    {
        return image;
    }
    else
    {
        return [self imageWithImage:image ratioToSize:newSize];
    }
}

//等比缩放
+(UIImage *)imageWithImage:(UIImage *)image ratioToSize:(CGSize)newSize
{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    float verticalRadio = newSize.height/height;
    float horizontalRadio = newSize.width/width;
    float radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    width = width*radio;
    height = height*radio;
    
    return [self imageWithImage:image scaledToSize:CGSizeMake(width,height)];
}

//缩放
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** 计算缓存大小 */
+ (float)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];//从前向后枚举器／／／／//
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        //        NSLog(@"fileName ==== %@",fileName);
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        //        NSLog(@"fileAbsolutePath ==== %@",fileAbsolutePath);
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    //    NSLog(@"folderSize ==== %lld",folderSize);
    return folderSize/(1024.0*1024.0);
}

#pragma mark - 计算缓存文件的大小的M
+ (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}
/** 用户ID转环信ID */
+ (NSString *)EasemoIdbyUserId:(NSString *)userId{
    
    NSString * EasemoId=[userId stringByReplacingOccurrencesOfString:@"@"withString:@"_.."];
    
    return EasemoId;
}

/** 环信ID转用户ID */
+ (NSString *)UserIDbyEasemoId:(NSString *)easemoId{
    
    NSString * userId=[easemoId stringByReplacingOccurrencesOfString:@"_.."withString:@"@"];
    
    return userId;
    
}
/** 用户ID组转环信ID组 */
+ (NSArray *)EasemoIdArrybyUserId:(NSArray *)userIdArry{
    NSMutableArray * EasemoIdArry=[[NSMutableArray alloc]init];
    
    for (int i = 0; i <userIdArry.count; i++) {
        [EasemoIdArry addObject:[self EasemoIdbyUserId:userIdArry[i]]];
    }
    return EasemoIdArry;
    
}

/** 环信ID组转用户ID组 */
+ (NSArray *)UserIDArrybyEasemoId:(NSArray *)easemoIdArry{
    NSMutableArray * userIdArry=[[NSMutableArray alloc]init];
    for (int i = 0; i <easemoIdArry.count; i++) {
        [userIdArry addObject:[self EasemoIdbyUserId:easemoIdArry[i]]];
    }
    return userIdArry;
}

// wifiIP
+ (NSString *) localWiFiIPAddress
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])  // Wi-Fi adapter
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}


// 字符串转十六进制
+ (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}


// 十六进制转字符串
+ (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}


/** 字典去NULL */

+ (NSDictionary *)dictionaryWithDictRemoveNull:(NSDictionary *)dict{
    
    NSMutableDictionary * MDict=[[NSMutableDictionary alloc]init];
    
    NSArray * KeyArry=[dict allKeys];
    
    for (int i = 0; i < KeyArry.count; i++) {
        
        NSString * dictStr=[NSString stringWithFormat:@"%@",[dict objectForKeyNotNull:KeyArry[i]]];
        dictStr=[dictStr stringByReplacingOccurrencesOfString:@"<null>" withString:@" "];
        
        dictStr=[dictStr stringByReplacingOccurrencesOfString:@"<NULL>" withString:@" "];
        [MDict setObject:dictStr forKey:KeyArry[i]];
        
    }
    
    //    NSLog(@"%@     %@",dict , MDict);
    
    return MDict;
    //
    //
    //
    //
    //
    //    NSString * dictStr=[NSString stringWithFormat:@"%@",dict];
    //
    //    dictStr=[dictStr stringByReplacingOccurrencesOfString:@"<null>" withString:@" "];
    //
    //    dictStr=[dictStr stringByReplacingOccurrencesOfString:@"<NULL>" withString:@" "];
    //
    //    dictStr=[dictStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //
    //    dictStr=[dictStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    //
    //    NSLog(@"%@",dictStr);
    //
    //    NSDictionary * dict2=[self dictionaryWithJsonString:dictStr];
    //
    //    return dict2;
}

/** 数组去NULL */

+ (NSArray  *)arryWithArryRemoveNull:(NSArray *)arry{
    
    NSString * arryStr=[NSString stringWithFormat:@"%@",arry];
    
    [arryStr stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
    
    [arryStr stringByReplacingOccurrencesOfString:@"<NULL>" withString:@""];
    
    //    NSArray * arry2=[self :arryStr];
    
    
    return arry;
}



/** 提示框 */
+ (void)showHUDWithStr:(NSString *)str
{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:ApplicationDelegate.window animated:YES];
//    hud.removeFromSuperViewOnHide = YES;
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.6];
//    hud.mode = MBProgressHUDModeText;
//    hud.detailsLabel.text = str;
//    hud.detailsLabel.textColor = [UIColor whiteColor];
//    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
//    hud.margin = 10;
//    [hud hideAnimated:YES afterDelay:2];
}

+ (void)showLoadingWith:(UIView *)view showText:(NSString *)showText{
    //初始化进度框，置于当前的View当中
//    MBProgressHUD *_HUD = [[MBProgressHUD alloc] initWithView:view];
//    _HUD.removeFromSuperViewOnHide = YES;
//    _HUD.mode = MBProgressHUDModeIndeterminate;
//    _HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    _HUD.bezelView.color = [UIColor colorWithWhite:0 alpha:0.6];
//    _HUD.contentColor = [UIColor whiteColor];
//    [view addSubview:_HUD];
//
//    //设置对话框文字
//    _HUD.label.text = showText;
//    //    //细节文字
//    //    _HUD.detailsLabel.text = @"请耐心等待";
//    //显示对话框
//    [_HUD showAnimated:YES];
    
}
+ (void)hideLoadHUDWith:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
    //    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}


/** 日期比较 */
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame){
        //相等  aa=0
        aa = 0;
    } else if (result == NSOrderedAscending) {
        //bDate比aDate大
        aa = 1;
    } else if (result == NSOrderedDescending) {
        //bDate比aDate小
        aa = -1;
    }
    
    return aa;
}


/** 时间比较 */
+ (NSInteger)compareTime:(NSString *)aTime withTime:(NSString *)bTime
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"HH:mm"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aTime];
    dtb = [dateformater dateFromString:bTime];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedSame){
        //相等  aa=0
        aa = 0;
    } else if (result == NSOrderedAscending) {
        //bDate比aDate大
        aa = 1;
    } else if (result == NSOrderedDescending) {
        //bDate比aDate小
        aa = -1;
    }
    
    return aa;
}

/** 字符限制 */
+ (NSString *)textFiledEditChangedWith:(UITextField *)textField MaxLength:(NSInteger)kMaxLength
{
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
    
    return textField.text;
}

/** 判断是否开启推送 */
+ (BOOL)isAllowedNotification
{
    
    //iOS8 check if user allow notification
    if(IsAfterIOS8) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (UIUserNotificationTypeNone != setting.types) {
            
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (UIRemoteNotificationTypeNone != type) {
            return YES;
        }
    }
    return NO;
}

/** 数组转json字符串*/
+ (NSString *)arrayToJSONString:(NSMutableArray *)array
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"json array is: %@", jsonResult);
    return jsonString;
}

/** 把多个json字符串转为一个json字符串*/
+ (NSString *)objArrayToJSON:(NSMutableArray *)array {
    NSString *jsonStr = @"[";
    for (NSInteger i = 0; i < array.count; ++i) {
        if (i != 0) {
            jsonStr = [jsonStr stringByAppendingString:@","];
        }
        jsonStr = [jsonStr stringByAppendingString:array[i]];
    }
    jsonStr = [jsonStr stringByAppendingString:@"]"];
    return jsonStr;
}

/** 字典转json格式字符串*/
+ (NSString*)dictionaryToJson:(NSMutableDictionary *)dict
{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    //    NSRange range = {0,jsonString.length};
    //
    //    //去掉字符串中的空格
    //    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    //    NSRange range2 = {0,mutStr.length};
    //
    //    //去掉字符串中的换行符
    //    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    //
    return mutStr;
}


/** 判断当前控制器是否正在显示 */
+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}


/** Label显示不同样式 */
+ (NSMutableAttributedString *)labelWithText:(NSString *)text Color:(UIColor *)color Font:(UIFont *)font range:(NSRange)range
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:text];
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    if (font != NULL) {
        [noteStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return noteStr;
}

/** 颜色渐变 */
+ (CAGradientLayer *)gradientWithColorsArr:(NSArray *)colorsArr frame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colorsArr;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = frame;
    return gradientLayer;
}

/** 制作图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (!color || size.width <=0 || size.height <=0){
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 剪切字符串转字典 */
+ (NSDictionary *)DictFromStrCut:(NSString*)Str Action:(NSString*)action
{
    NSRange range1=[Str rangeOfString:[NSString stringWithFormat:@"%@=",action]];
    
    if (range1.length) {
        Str=[Str substringFromIndex:range1.location+range1.length];
        
        Str=[Str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",Str);
        NSData *jsonData = [Str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            return nil;
        }
        return dict;
    } else {
        return nil;
    }
}

/** 获取顶层viewController */
+ (UIViewController *)topViewController
{
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

/** 判断字符串是否为URL */
+ (BOOL)urlValidation:(NSString *)string
{
    NSError *error;
    NSString *regulaStr =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive                         error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        NSString* substringForMatch = [string substringWithRange:match.range];
        return YES;
    }
    return NO;
}

- (void)GeneralButtonActionWith:(UIView *)view{
    //初始化进度框，置于当前的View当中
//    MBProgressHUD *_HUD = [[MBProgressHUD alloc] initWithView:view];
//    [view addSubview:_HUD];
//
//    //设置对话框文字
//    _HUD.label.text = @"加载中";
//    //细节文字
//    _HUD.detailsLabel.text = @"请耐心等待";
//    //显示对话框
//    [_HUD showAnimated:YES];
    
}

/**
 * 压缩图片到指定文件大小
 *
 * @param image 目标图片
 * @param maxLength 目标大小（最大值）
 *
 * @return 返回的图片文件
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)maxLength{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),(NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}

/** 压缩图片 */
+ (NSData *)zipNSDataWithImage:(UIImage *)sourceImage
{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}

+ (BOOL)isUserNotificationEnable { // 判断用户是否允许接收通知
    BOOL isEnable = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    } else { // iOS版本 <8.0 处理逻辑
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        isEnable = (UIRemoteNotificationTypeNone == type) ? NO : YES;
    }
    return isEnable;
}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
+ (void)goToAppSystemSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:url options:@{} completionHandler:nil];
        } else {
            [application openURL:url];
        }
    }
}
+ (UIColor *)bGviewBackgroudColor {

    BOOL darkModel = NO;
    if (@available(iOS 13.0, *)) {
        if(UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            darkModel = YES;
        }
    }
    
    if (darkModel) {
        return [UIColor colorWithRed:33/255.f green:33/255.f blue:33/255.f alpha:1.0f];
    } else {
    
        return [UIColor whiteColor];
    }
}
@end

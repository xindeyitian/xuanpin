//
//  DHCCToolsMethod.m
//  MobileBanking
//
//  Created by wuzhao on 16/8/15.
//  Copyright © 2016年 dhcc. All rights reserved.
//

#import "DHCCToolsMethod.h"
#import "NSString+Base64.h"
#import "UITextField+Extension.h"
@implementation DHCCToolsMethod
//字典 通过value找key

+(NSString *)keyForValueWithDic:(NSDictionary *)dic andValue:(NSString *)value{
    NSString *key;
    for (NSString *keyStr in [dic allKeys]) {
        if ([dic[keyStr] isEqualToString:value]) {
            key = keyStr;
        }
    }
    return key;
}

/** 弹出提示框 */
+ (void)alertMessage:(NSString *)message vc:(UIViewController *)vc{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    [alertController addAction:alertAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
}

// 弹出提示框，message居左
+ (void)alertMessageLeftWithMessage:(NSString *)message vc:(UIViewController *)vc {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIView *subView1 = alertController.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    NSLog(@"%@",subView5.subviews);
    //取title和message：
    UILabel *titleLabel = subView5.subviews[0];
    UILabel *messageLabel = subView5.subviews[1];
    titleLabel.textColor = [UIColor blueColor];
    messageLabel.textAlignment = NSTextAlignmentJustified;
    messageLabel.font = [UIFont systemFontOfSize:12];
    
    //修改title
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:22/255.0 green:127/255.0 blue:251/255.0 alpha:1] range:NSMakeRange(0, 2)];
    [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
    }];
    [alertController addAction:alertAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

//非空校验
+(Boolean)IsNil:(NSString *)value{
    if ([value isEqualToString:@""]||value == nil) {
        return YES;
    }
    return NO;
}
/** 获取当前时间 */
+ (NSString *)getCurrentDateTime{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateTime = [dateFormatter stringFromDate:[NSDate new]];
    return currentDateTime;
}
/** 获取当前日期 */
+ (NSString *)getCurrentDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate new]];
    return currentDate;
}
/**获取当前日期前day天的日期 */
+ (NSString *)getDateFrontDay:(NSInteger)day{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSTimeInterval b = a - (24*3600*day);
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:b];
    
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *timeStr = [timeFormatter stringFromDate:date];
    return timeStr;
}
/**20170309格式化为2017-03-09*/
+ (NSString *)dateStrFormaterDate:(NSString *)dateStr{
    NSString *str;
    if (dateStr.length >= 8) {
        NSRange range = NSMakeRange(0, 4);
        NSRange range2 = NSMakeRange(4, 2);
        NSRange range3 = NSMakeRange(6, 2);
        str = [NSString stringWithFormat:@"%@-%@-%@",[dateStr substringWithRange:range],[dateStr substringWithRange:range2],[dateStr substringWithRange:range3]];
    }
    
    return str;
}

/**20170309格式化为2017.03.09*/
+ (NSString *)dateStrFormaterDate:(NSString *)dateStr withFormart:(NSString*)formart{
    
    if (dateStr.length >= 8) {
        NSRange range = NSMakeRange(0, 4);
        NSRange range2 = NSMakeRange(4, 2);
        NSRange range3 = NSMakeRange(6, 2);
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",[dateStr substringWithRange:range],formart,[dateStr substringWithRange:range2],formart,[dateStr substringWithRange:range3]];
        return str;
    }
    return dateStr;
    
}

/**2017.03.09格式化为20170309*/
+ (NSString *)strFormaterDate:(NSString *)dateStr withFormart:(NSString*)formart{
    NSArray *arr = [dateStr componentsSeparatedByString:formart];
    NSMutableString *apendStr = [NSMutableString string];
    if (arr && arr.count > 0) {
        for (NSString *str in arr) {
            [apendStr appendString:str];
        }
    }
    return apendStr;
}

/**20170309-20170309格式化为2017.03.09-2027.03.09*/
+ (NSString *)strFormaterDateStr:(NSString *)dateStr withFormart:(NSString*)formart{
    
    NSArray *arr = [dateStr componentsSeparatedByString:@"-"];
    NSMutableString *aStr = [NSMutableString string];
    for (NSString *timeStr in arr) {
        NSString *sub = [DHCCToolsMethod dateStrFormaterDate:timeStr withFormart:formart];
        [aStr appendString:sub];
        [aStr appendString:@"-"];
    }
    NSString *apendStr = [aStr substringToIndex:aStr.length-1];
    return apendStr;
}

/**2017.03.09-2027.03.09格式化为20170309-20170309*/
+ (NSString *)dateFormaterStr:(NSString *)dateStr withFormart:(NSString*)formart{
    
    NSArray *arr = [dateStr componentsSeparatedByString:@"-"];
    NSMutableString *aStr = [NSMutableString string];
    for (NSString *timeStr in arr) {
        NSString *sub;
        if ([timeStr isEqualToString:@"长期"]) {
            sub = [DHCCToolsMethod strFormaterDate:[NSString stringWithFormat:@"2999.12.31"] withFormart:formart];
        }else{
            sub = [DHCCToolsMethod strFormaterDate:timeStr withFormart:formart];
        }
        [aStr appendString:sub];
        [aStr appendString:@"-"];
    }
    NSString *apendStr = [aStr substringToIndex:aStr.length-1];
    return apendStr;
}

/** 日期合法的校验 */
+ (BOOL)validateDate:(NSString *)value{
    
    BOOL isDate = YES;
    NSString *regex = @"^(\\d{4})[.](0\\d{1}|1[0-2])[.](0\\d{1}|[12]\\d{1}|3[0-1])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    NSArray *arr = [value componentsSeparatedByString:@"-"];
    for (NSString *timeStr in arr) {
        NSString *sub;
        if ([timeStr isEqualToString:@"长期"]) {
            sub = @"2999.12.31";
        }else{
            sub = timeStr;
        }
        if (![predicate evaluateWithObject:sub]) {
            isDate = NO;
            return isDate;
        }
    }
    return isDate;
}


/** 身份证合法的校验 */
+ (BOOL)validateIDCardNumber:(NSString *)identityCard {
//    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    
//    NSInteger length =0;
//    if (!value) {
//        return NO;
//    }else {
//        length = value.length;
//        
//        if (length !=15 && length !=18) {
//            return NO;
//        }
//    }
//    // 省份代码
//    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
//    
//    NSString *valueStart2 = [value substringToIndex:2];
//    BOOL areaFlag =NO;
//    for (NSString *areaCode in areasArray) {
//        if ([areaCode isEqualToString:valueStart2]) {
//            areaFlag =YES;
//            break;
//        }
//    }
//    
//    if (!areaFlag) {
//        return false;
//    }
//    
//    
//    NSRegularExpression *regularExpression;
//    NSUInteger numberofMatch;
//    
//    int year =0;
//    switch (length) {
//        case 15:
//            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
//            
//            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
//                
//                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
//                                                                         options:NSRegularExpressionCaseInsensitive
//                                                                           error:nil];//测试出生日期的合法性
//            }else {
//                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
//                                                                         options:NSRegularExpressionCaseInsensitive
//                                                                           error:nil];//测试出生日期的合法性
//            }
//            numberofMatch = [regularExpression numberOfMatchesInString:value
//                                                               options:NSMatchingReportProgress
//                                                                 range:NSMakeRange(0, value.length)];
//            
//            
//            if(numberofMatch >0) {
//                return YES;
//            }else {
//                return NO;
//            }
//        case 18:
//            
//            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
//            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
//                
//                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
//                                                                        options:NSRegularExpressionCaseInsensitive
//                                                                          error:nil];//测试出生日期的合法性
//            }else {
//                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
//                                                                        options:NSRegularExpressionCaseInsensitive
//                                                                          error:nil];//测试出生日期的合法性
//            }
//            numberofMatch = [regularExpression numberOfMatchesInString:value
//                                                               options:NSMatchingReportProgress
//                                                                 range:NSMakeRange(0, value.length)];
//            
//            
//            if(numberofMatch >0) {
//                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
//                int Y = S %11;
//                NSString *M =@"F";
//                NSString *JYM =@"10X98765432";
//                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
//                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
//                    return YES;// 检测ID的校验位
//                }else {
//                    return NO;
//                }
//                
//            }else {
//                return NO;
//            }
//        default:
//            return false;
//    }
    
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;

}

#pragma mark - 校验用户名
+ (BOOL)validateUserName:(NSString *)userName{
    NSString *userNameRegex = @"^[\u4E00-\u9FA5\uf900-\ufa2d]{2,8}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];//Cocoa框架中的NSPredicate用于查询，原理和用法都类似于SQL中的where，作用相当于数据库的过滤取
    BOOL isMatch = [userNamePredicate evaluateWithObject:userName];//判读userNameField的值是否吻合
    return isMatch;
}

#pragma mark - 校验密码
+ (BOOL)validatePassword:(NSString *)passWord{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

#pragma mark - 邮箱
+ (BOOL) validateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark - 手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile{
    
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 16[6], 17[5, 6, 7, 8], 18[0-9], 170[0-9], 19[89]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
     * 联通号段: 130,131,132,155,156,185,186,145,175,176,1709,166
     * 电信号段: 133,153,180,181,189,177,1700,199
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$";
    
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
    
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    
    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobile] == YES)
       || ([regextestcm evaluateWithObject:mobile] == YES)
       || ([regextestct evaluateWithObject:mobile] == YES)
       || ([regextestcu evaluateWithObject:mobile] == YES)) {
        return YES;
    } else {
        return NO;
    }
    
    //手机号以13， 15，18开头，八个 \d 数字字符
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:mobile];
}
#pragma mark - 银行卡号验证
+ (BOOL) validateBankCardNumber:(NSString *)cardNum{
    
    NSString * lastNum = [[cardNum substringFromIndex:(cardNum.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[cardNum substringToIndex:(cardNum.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0)?YES:NO;
}

#pragma mark - 姓名加密  赵日天  --> 赵**
+ (NSString *)userNameFromString:(NSString *)name{
    if (name.length>1) {
        
            NSUInteger count = name.length - 1;
            NSMutableString *str = [NSMutableString string];
            for (int i = 0; i<count; i++) {
                [str appendString:@"*"];
            }
            return [NSString stringWithFormat:@"%@%@", [name substringToIndex:1],str];

    } else {
        return @"";
    }
    
}



#pragma mark - 加空格 222222222222012  --> 2222 2222 2222 012
+ (NSString *)formartFromString:(NSString *)str{
    
    NSInteger index = str.length / 4;
    NSString *string = @"";
    for (int i = 0; i<index; i++) {
        string = [NSString stringWithFormat:@"%@ %@",string,[str substringWithRange:NSMakeRange(i*4, 4)]];
    }
    string = [NSString stringWithFormat:@"%@ %@",string,[str substringWithRange:NSMakeRange(index*4, str.length-index*4)]];
    
    return string;
    
}

#pragma mark - 银行账户尾号
+ (NSString *)acountFinalNumString:(NSString *)account {
    if (account.length>4) {
        return [NSString stringWithFormat:@"%@", [account substringFromIndex:account.length-4]];
    } else {
        return @"";
    }
}

#pragma mark - 手机号加密  15339255159  --> 153****5159
+ (NSString *)phoneFromPhoneString:(NSString *)phone{
    if (phone.length>8) {
        return [NSString stringWithFormat:@"%@****%@", [phone substringToIndex:3], [phone substringFromIndex:7]];
    } else {
        return @"";
    }
    
}
#pragma mark - 身份证号加密  412724197103192930  --> 412*******2930
+ (NSString *)certFromCert:(NSString *)cert{
    if (cert) {
        if (cert.length >=8) {
            return [NSString stringWithFormat:@"%@***********%@", [cert substringToIndex:3], [cert substringWithRange:NSMakeRange(cert.length - 4, 4)]];
        } else {
            return cert;
        }
    } else {
        return @"";
    }
    
    
    
    //    if (cert.length == 15) {
    //        return [NSString stringWithFormat:@"%@******%@", [cert substringToIndex:4], [cert substringFromIndex:11]];
    //    } else if(cert.length == 18){// 18位
    //        return [NSString stringWithFormat:@"%@******%@", [cert substringToIndex:4], [cert substringFromIndex:14]];
    //    } else {
    //        return [NSString stringWithFormat:@"%@******%@", [cert substringToIndex:4], [cert substringWithRange:NSMakeRange(cert.length - 4, 4)]];
    //    }
    
}

#pragma mark - 合同号  123456789  --> 1234****6789
+ (NSString *)cont_noFromCont_no:(NSString *)cont_no{
    if (cont_no.length>12) {
        return [NSString stringWithFormat:@"%@****%@", [cont_no substringToIndex:4], [cont_no substringFromIndex:[cont_no length] - 4]];
    } else {
        return cont_no;
    }
}

//由身份证号返回为性别
+ (NSString *)sexStrFromIdentityCard:(NSString *)numberStr {
    NSString *result = nil;
    BOOL isAllNumber = YES;
    if([numberStr length]<17)
        return result;
    //**截取第17为性别识别符
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(16, 1)];
    //**检测是否是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    NSInteger sexNumber = [fontNumer integerValue];
    if(sexNumber%2==1)
        result = @"男";
    else if (sexNumber%2==0)
        result = @"女";
    return result;
}

#pragma mark --银行卡号加密  412724197103192930  --> 4127******2930
+ (NSString *)bankNoForCert:(NSString *)cert{
    if (cert.length > 8) {
        
        return [NSString stringWithFormat:@"%@ **** *** **** %@", [cert substringToIndex:4], [cert substringWithRange:NSMakeRange(cert.length - 3, 3)]];
    }else{
        
        return cert;
    }
    
}
#pragma mark --银行卡号加密  412724197103192930  --> **** *** ****2930
+ (NSString *)bankNoForCert2:(NSString *)cert{
    if (cert.length > 8) {
        
        return [NSString stringWithFormat:@"****  ****  ****  %@", [cert substringWithRange:NSMakeRange(cert.length - 4, 4)]];
    }else{
        
        return cert;
    }
    
}

#pragma mark --银行卡号加密  412724197103192930  --> **** **** **** 3192 930
+ (NSString *)bankNoForCert3:(NSString *)cert{
    if (cert.length >= 12) {
        NSInteger num = cert.length - 12;
        if (cert.length <= 19 && cert.length >= 16 ) {
            if (cert.length == 17) {
                return [NSString stringWithFormat:@"**** **** **** %@%@", [cert substringWithRange:NSMakeRange(cert.length - num, 4)],[cert substringWithRange:NSMakeRange(cert.length - (num -4), (num -4))]];
            }else{
                return [NSString stringWithFormat:@"**** **** **** %@ %@", [cert substringWithRange:NSMakeRange(cert.length - num, 4)],[cert substringWithRange:NSMakeRange(cert.length - (num -4), (num -4))]];
            }
            
        }else{
            return [NSString stringWithFormat:@"**** **** **** %@", [cert substringWithRange:NSMakeRange(cert.length - num, num)]];
        }
        
    }else{
        return cert;
    }
    
}

#pragma mark - 金额部分公共方法
/** 金额限制
 1.要求用户输入首位不能为小数点;
 2.小数点后不超过两位;
 3.小数点不能超过1位；
 3.如果首位为0，后面仅能输入小数点，如果输入的是非零的数字，则替换0
 4.输入金额不超过10位(整数金额)
 5.删除的时候，如果删除的是小数点紧跟的数字，则小数点跟随其一块删除。
 */
+ (BOOL)formatMoneyWithTextField:(UITextField *)textField range:(NSRange)range replacementString:(NSString *)string{
    
    textField.text = [textField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    if ([string length] > 0){
        
        BOOL isHaveDian = YES;
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian = NO;
        }
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为小数点
            if([textField.text length] == 0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            // 当首字母为0，第二位只能为 ‘.’
            if([textField.text length]== 1 && [textField.text isEqualToString:@"0"]){
                if(single != '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
            }
            
            if (!isHaveDian) {
                if (single != '.' && textField.text.length == 10) {
                    //[textField.text stringByReplacingCharactersInRange:range withString:@""];
                    textField.text = [DHCCToolsMethod separatedDigitStringWithStr:textField.text];
                    return NO;
                }
            }
            
            // 下一个输入为 '.' 时
            if (single == '.'){
                if(!isHaveDian && textField.text.length < 11){//text中还没有小数点，且整数小于等于10位，可以输入
                    isHaveDian=YES;
                    
                    return YES;
                } else {
                    //[textField.text stringByReplacingCharactersInRange:range withString:@""];
                    textField.text = [DHCCToolsMethod separatedDigitStringWithStr:textField.text];
                    return NO;
                }
            } else {
                if (isHaveDian){//存在小数点
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    if (ran.location >= 4 && ran.location < 7) {
                        ran.location += 1;
                    } else if(ran.location >= 7 && ran.location < 10){
                        ran.location += 2;
                    } else if (ran.location >=10){
                        ran.location += 3;
                    } else {
                        ran.location = ran.location;
                    }
                    NSInteger tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        //[textField.text stringByReplacingCharactersInRange:range withString:@""];
                        textField.text = [DHCCToolsMethod separatedDigitStringWithStr:textField.text];
                        return NO;
                    }
                } else {
                    return YES;
                }
            }
        }else {//输入的数据格式不正确
            return NO;
        }
    } else {
        return YES;
    }
}

#pragma mark - 金额数字加 ","
+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString{
    
    digitString = [digitString stringByReplacingOccurrencesOfString:@"," withString:@""];
    if ([digitString rangeOfString:@"."].location == NSNotFound) {
        
        return [NSString stringWithFormat:@"%@",[self zhengshuAdddouhao:digitString]];
        
    } else {
        NSArray *array = [digitString componentsSeparatedByString:@"."];
        NSString *zheng = [self zhengshuAdddouhao:array[0]];
        NSString *returnStr = [zheng stringByAppendingFormat:@"%@%@", @".", array[1]];
        return returnStr;
    }
}
#pragma mark - 整数金额加 “,”
+ (NSString *)zhengshuAdddouhao:(NSString *)digitString{
    
    if (digitString.length <= 3) {
        return  digitString;
    } else {
        NSMutableString *processString = [NSMutableString stringWithString:digitString];
        NSInteger location = processString.length - 3;
        NSMutableArray *processArray = [NSMutableArray array];
        while (location >= 0) {
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            [processArray addObject:temp];
            if (location < 3 && location > 0){
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                [processArray addObject:t];
            }
            location -= 3;
        }
        NSMutableArray *resultsArray = [NSMutableArray array];
        int k = 0;
        for (NSString *str in processArray){
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            if (str.length > 2 && k < processArray.count ){
                [tmp insertString:@"," atIndex:0];
                [resultsArray addObject:tmp];
            } else {
                [resultsArray addObject:tmp];
            }
        }
        NSMutableString *resultString = [NSMutableString string];
        for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--){
            NSString *tmp = [resultsArray objectAtIndex:i];
            [resultString appendString:tmp];
        }
        return resultString;
    }
}
#pragma mark - 金额去除逗号 ","
+ (NSString *)amountToRemoveCommas:(NSString *)string{
    return [string stringByReplacingOccurrencesOfString:@"," withString:@""];
}
#pragma mark - 小写金额转化为大写金额
+ (NSString *)changetochinese:(NSString *)numstr {
    
    double numberals=[numstr doubleValue];
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    NSArray *unitname = @[@"",@"万",@"亿",@"万亿"];
    
    //金额乘以100转换成字符串（去除圆角分数值）
    NSString *valstr=[NSString stringWithFormat:@"%.2f",numberals];
    NSString *prefix;
    NSString *suffix;
    
    if (valstr.length<=2) {
        prefix=@"零元";
        if (valstr.length==0) {
            suffix=@"零角零分";
        } else if (valstr.length==1) {
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr intValue]]];
        } else {
            NSString *head=[valstr substringToIndex:1];
            NSString *foot=[valstr substringFromIndex:1];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar objectAtIndex:[foot intValue]]];
        }
    } else {
        prefix=@"";
        suffix=@"";
        int flag=(int)(valstr.length-2);
        NSString *head=[valstr substringToIndex:flag-1];
        NSString *foot=[valstr substringFromIndex:flag];
        if (head.length>13) {
            return @"数值太大（最大支持13位整数），无法处理";
        }
        
        //处理整数部分
        NSMutableArray *ch=[[NSMutableArray alloc]init];
        for (int i = 0; i < head.length; i++) {
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            [ch addObject:str];
        }
        int zeronum=0;
        for (int i=0; i<ch.count; i++) {
            int index=(ch.count -i-1)%4;//取段内位置
            int indexloc=(int)(ch.count -i-1)/4;//取段位置
            if ([[ch objectAtIndex:i]isEqualToString:@"0"]) {
                zeronum++;
            } else {
                if (zeronum!=0) {
                    if (index!=3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum=0;
                }
                prefix=[prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                prefix=[prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
            }
            if (index ==0 && zeronum<4) {
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
            }
        }
        prefix =[prefix stringByAppendingString:@"元"];
        
        //处理小数位
        if ([foot isEqualToString:@"00"]) {
            suffix =[suffix stringByAppendingString:@"整"];
        } else if ([foot hasPrefix:@"0"]) {
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[footch intValue] ]];
        } else {
            NSString *headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar objectAtIndex:[footch intValue]]];
        }
    }
    
    return [prefix stringByAppendingString:suffix];
}

#pragma mark - 银行卡卡号加 空格   银行卡卡号4位一空格方法
//检测是否为纯数字
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
+ (BOOL)formatBankCardNoWithTextField:(UITextField *)textField range:(NSRange)range replacementString:(NSString *)string{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    //检测是否为纯数字
    if ([self isPureInt:string]) {
        //添加空格，每4位之后，4组之后不加空格，格式为xxxx xxxx xxxx xxxx xxxxxxxxxxxxxx
        if (textField.text.length % 5 == 4 && textField.text.length < 22) {
            textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
        }
        //只要30位数字  23位
        if ([toBeString length] >= 19+4){
            toBeString = [toBeString substringToIndex:19+4];// 共23位
            textField.text = toBeString;
            //[textField resignFirstResponder];
            return NO;
        }
    } else if ([string isEqualToString:@""]) { // 删除字符
        if ((textField.text.length - 2) % 5 == 4 && textField.text.length < 22) {
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
        }
        return YES;
    } else{
        return NO;
    }
    return YES;
}
//截取字符串后四位
+(NSString *)subStrtoLastFour:(NSString *)str{
    
    NSUInteger len = str.length;
    NSString *result = [[str substringFromIndex:(len - 4)] substringToIndex:4];
    
    return result;
}

//截取字符串前五位
+ (NSString *)subFrontFour:(NSString *)str{
    
    NSString *result = [[str substringFromIndex:0] substringToIndex:4];
    
    return result;
}

//截取首字母
+ (NSString *)subFrontOne:(NSString *)str{
    
    NSString *result = [[str substringFromIndex:0] substringToIndex:1];
    
    return result;
}

//截取从二到结束
+ (NSString *)subTwoToLast:(NSString *)str{
    
    NSString *result = [[str substringFromIndex:1] substringToIndex:(str.length - 1)];
    
    return result;
}
//字符串加空格
+(NSString*)formatBankCardNo:(NSString *)string{
    
    NSString *result = @"";
    //检测是否为纯数字
    if ([self isPureInt:string]) {
        NSInteger strLen = string.length;
        int strLen1 = (int)roundf((strLen/4));
        for (int i = 0; i<= strLen1; i++) {
            if (i==strLen1) {
                result =[NSString stringWithFormat:@"%@%@ ",result,[[string substringFromIndex:(4*i)] substringToIndex:(strLen - 4*i)]];
            }else{
                
                result =[NSString stringWithFormat:@"%@%@ ",result,[[string substringFromIndex:(4*i)] substringToIndex:4]];
            }
            
        }
        
    }
    return result;
}
#pragma mark - 去除空格
+ (NSString *)amountToRemoveSpace :(NSString *)string{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}
//
////字符串加逗号
//+(NSString*)amountToAddComma:(NSString *)string{
//
//    NSArray *arr = [string componentsSeparatedByString:@"."];
//    if (arr.count <= 0) {
//        return nil;
//    }
//    NSString *result = @",";
//    NSInteger strLen = string.length;
//    int strLen1 = (int)roundf((strLen/3));
//    for (int i = 0; i<= strLen1; i++) {
//        if (i==strLen1) {
//            result =[NSString stringWithFormat:@"%@%@ ",result,[[string substringFromIndex:(3*i)] substringToIndex:(strLen - 3*i)]];
//        }else{
//            result =[NSString stringWithFormat:@"%@%@ ",result,[[string substringFromIndex:(3*i)] substringToIndex:3]];
//        }
//
//    }
//
//    return result;
//}
//#pragma mark - 去除逗号
//+ (NSString *)amountToRemoveComma:(NSString *)string{
//    return [string stringByReplacingOccurrencesOfString:@"," withString:@""];
//}
#pragma mark - image转base64
+(NSString *)imageTurnToBase64:(UIImage *)image{
    CGFloat compression = 0.9f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ((imageData.length/1024) > 500) {
        compression -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSString *encodedString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedString;
}



#pragma mark --- 金额小写转大写
+(NSString *)digitUppercase:(NSString *)money
{
    NSMutableString *moneyStr=[[NSMutableString alloc] initWithString:money];
    NSArray *MyScale=@[@"分", @"角", @"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *MyBase=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    NSMutableString *M=[[NSMutableString alloc] init];
    [moneyStr deleteCharactersInRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 1)];
    for(NSInteger i=moneyStr.length;i>0;i--)
    {
        NSInteger MyData=[[moneyStr substringWithRange:NSMakeRange(moneyStr.length-i, 1)] integerValue];
        [M appendString:MyBase[MyData]];
        if([[moneyStr substringFromIndex:moneyStr.length-i+1] integerValue]==0&&i!=1&&i!=2)
        {
            [M appendString:@"元整"];
            break;
        }
        [M appendString:MyScale[i-1]];
    }
    return M;
}

+(NSString *)toCapitalLetters:(NSString *)money
{
    //首先转化成标准格式        “200.23”
    NSMutableString *tempStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[money doubleValue]]];
    //位
    NSArray *carryArr1=@[@"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *carryArr2=@[@"分",@"角"];
    //数字
    NSArray *numArr=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    
    NSArray *temarr = [tempStr componentsSeparatedByString:@"."];
    //小数点前的数值字符串
    NSString *firstStr=[NSString stringWithFormat:@"%@",temarr[0]];
    //小数点后的数值字符串
    NSString *secondStr=[NSString stringWithFormat:@"%@",temarr[1]];
    
    //是否拼接了“零”，做标记
    bool zero=NO;
    //拼接数据的可变字符串
    NSMutableString *endStr=[[NSMutableString alloc] init];
    
    /**
     *  首先遍历firstStr，从最高位往个位遍历    高位----->个位
     */
    
    //去除整数部分零开头
    if ([firstStr hasPrefix:@"0"]) {
       
        firstStr = nil;
    }
    
    for(int i=(int)firstStr.length;i>0;i--)
    {
        //取最高位数
        NSInteger MyData=[[firstStr substringWithRange:NSMakeRange(firstStr.length-i, 1)] integerValue];
        
        if ([numArr[MyData] isEqualToString:@"零"]) {
            
            if ([carryArr1[i-1] isEqualToString:@"万"]||[carryArr1[i-1] isEqualToString:@"亿"]||[carryArr1[i-1] isEqualToString:@"元"]||[carryArr1[i-1] isEqualToString:@"兆"]) {
                //去除有“零万”
                if (zero) {
                    endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:(endStr.length-1)]];
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }else{
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }
                
                //去除有“亿万”、"兆万"的情况
                if ([carryArr1[i-1] isEqualToString:@"万"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"亿"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                }
                //去除“兆亿”
                if ([carryArr1[i-1] isEqualToString:@"亿"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                }
                
                
            }else{
                if (!zero) {
                    [endStr appendString:numArr[MyData]];
                    zero=YES;
                }
            }
            
        }else{
            //拼接数字
            [endStr appendString:numArr[MyData]];
            //拼接位
            [endStr appendString:carryArr1[i-1]];
            //不为“零”
            zero=NO;
        }
    }
    
    /**
     *  再遍历secondStr    角位----->分位
     */
    
    if ([secondStr isEqualToString:@"00"] && firstStr) {
        [endStr appendString:@"整"];
    }
    
    if (![secondStr isEqualToString:@"00"]&& firstStr){
        [endStr appendString:@"零"];
    }
    
    if(![secondStr isEqualToString:@"00"]){
        
        for(int i=(int)secondStr.length;i>0;i--)
        {
            //取最高位数
            NSInteger MyData=[[secondStr substringWithRange:NSMakeRange(secondStr.length-i, 1)] integerValue];
            
            if ([secondStr hasPrefix:@"0"]) {
                NSInteger MyData=[[secondStr substringFromIndex:1] integerValue];
                [endStr appendString:numArr[MyData]];
                [endStr appendString:carryArr2[i-2]];
                break;

            }else{
                
                if (secondStr.length>1 && ![secondStr hasSuffix:@"0"]) {
                    
                    [endStr appendString:numArr[MyData]];
                    [endStr appendString:carryArr2[i-1]];
                }else{
                
                    [endStr appendString:numArr[MyData]];
                    [endStr appendString:carryArr2[i-1]];
                    i--;
                }
                
            }
            
        }
    }
    
    return endStr;
}


#pragma mark - tableView多余分割线
+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark - float校验
+(BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}


#pragma mark - 计算两个时间之间的天数
+(NSString *)calculatorDayfromStartDate:(NSString *)startDateStr endDate:(NSString *)endDateStr{
    NSDate *startDate = [self StringTODate:startDateStr];
    NSDate *endDate = [self StringTODate:endDateStr];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    NSInteger days;
    days = ((int)time)/(3600*24);  //一天是24小时*3600秒
    NSString * dateValue = [NSString stringWithFormat:@"%li",(long)days];
    return dateValue;
}

#pragma mark - 字符串转date
+(NSDate *)StringTODate:(NSString *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MMMM-dd";
    [dateFormatter setMonthSymbols:[NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil]];
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;
}
#pragma mark - 登陆返回数据保存处理
//+(void)returnDate:(NSMutableDictionary *)responseData{
//    if (responseData[@"prdtLists"][0]) {
//        NSDictionary *prdtLists = responseData[@"prdtLists"][0];
//        if (prdtLists[@"prdtList"]) {
//
//            [DHCCUserInfo shareUserInfo].bindCardArr = [DHCCBindCardBean mj_objectArrayWithKeyValuesArray:prdtLists[@"prdtList"]];
//
//            NSMutableArray *payCardsArr = [NSMutableArray array];
//            NSMutableArray *payAccNos = [NSMutableArray array];
//            NSMutableArray *acceptCardsArray = [NSMutableArray array];
//            NSMutableArray *acceptAccNos = [NSMutableArray array];
//            // 保存付款卡信息，即收款卡信息
//            for (NSInteger i = 0; i < [DHCCUserInfo shareUserInfo].bindCardArr.count; i ++) {
//                DHCCBindCardBean *bangAcc = [DHCCUserInfo shareUserInfo].bindCardArr[i];
//                // 付款方卡，本行绑定卡
//                if ([bangAcc.ourBank isEqualToString:@"1"] && [bangAcc.eleAccBind isEqualToString:@"0"]) {/** 付款帐号必须是 本行ourBank 1 ，并且是本行的下挂帐号（即不是电子帐户的下挂帐号） eleAccBind 0，            ourBank 本行账号标志： 是：1 否：0    电子账号绑卡标志：  1：是  0：否 */
//                    [payCardsArr addObject:bangAcc];
//                    [payAccNos addObject:bangAcc.cifAcctno];
//                }
//
//                if (i == 0) {
//                    // 同名的收款卡（电子帐户绑卡（包括本行、外行））
//                    [acceptCardsArray addObject:bangAcc];
//                    [acceptAccNos addObject:bangAcc.cifAcctno];
//                } else {
//                    NSString *flag = @"0";
//                    for (NSInteger j = 0; j < acceptCardsArray.count; j ++) {
//                        DHCCBindCardBean *acceptCard = acceptCardsArray[j];
//                        if ([bangAcc.cifAcctno isEqualToString:acceptCard.cifAcctno]) {
//                            flag = @"1";
//
//                        }
//                    }
//                    if ([flag isEqualToString:@"0"]) {
//                        [acceptCardsArray addObject:bangAcc];
//                        [acceptAccNos addObject:bangAcc.cifAcctno];
//                    }
//                }
//            }
//            [DHCCUserInfo shareUserInfo].payCardsArray = payCardsArr;
//            [DHCCUserInfo shareUserInfo].payAccNos = payAccNos;
//            [DHCCUserInfo shareUserInfo].acceptCardsArray = acceptCardsArray;
//            [DHCCUserInfo shareUserInfo].acceptAccNos = acceptAccNos;
//        }
//    }
//}
//时间戳转时间
+(NSString *)timestampSwitchTime:(NSString *)timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]/1000.0];
    
    NSLog(@"1296035591  = %@",confromTimesp);
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    
    return confromTimespStr;
}
//移除nav中的控制器
+(void)removeNavToCotroller:(NSString *)VCName Nav:(UINavigationController *)nav{
    
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:nav.viewControllers];
    for (UIViewController *vc in marr) {
        Class class = NSClassFromString(VCName);
        if ([vc isKindOfClass:class]) {
            [marr removeObject:vc];
            break;
        }
    }
    nav.viewControllers = marr;
}

//跳转到控制器
+(void)ToOneController:(NSString *)VCName Nav:(UINavigationController *)nav{
    for (int i = 0; i<nav.viewControllers.count; i++) {
        UIViewController *vc =  [nav.viewControllers objectAtIndex:i];
        
        Class class = NSClassFromString(VCName);
        if (vc.class == class) {
            UIViewController *vc =  [nav.viewControllers objectAtIndex:i];
            [nav popToViewController:vc animated:YES];
        }
    }
}

#pragma mark - 升序排序
+ (NSMutableArray *)sortArrayAscendingWithArray:(NSMutableArray *)prdtArray dictKey:(NSString *)key {
    for(int i=0;i<prdtArray.count;i++){
        for (int j=0; j<prdtArray.count - i - 1; j++) {
            // 比较两个相邻的元素
            if ([prdtArray[j][key] floatValue] > [prdtArray[j + 1][key] floatValue]) {
                NSDictionary *t = prdtArray[j];
                prdtArray[j] = prdtArray[j + 1];
                prdtArray[j + 1] = t;
            }
        }
    }
    NSLog(@"排序后的数组%@",prdtArray);
    return prdtArray;
}
#pragma mark - 降序排序
+ (NSMutableArray *)sortArrayDescendingWithArray:(NSMutableArray *)prdtArray dictKey:(NSString *)key {
    for(int i=0;i<prdtArray.count;i++){
        for (int j=0; j<prdtArray.count - i - 1; j++) {
            // 比较两个相邻的元素
            if ([prdtArray[j][key] floatValue] < [prdtArray[j + 1][key] floatValue]) {
                NSDictionary *t = prdtArray[j];
                prdtArray[j] = prdtArray[j + 1];
                prdtArray[j + 1] = t;
            }
        }
    }
    NSLog(@"排序后的数组%@",prdtArray);
    return prdtArray;
}

#pragma mark - 身份证加空格   610126 19900213 7337
+ (BOOL)formatCertNoWithTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if ([string isEqualToString:@""]) { // 删除字符
        if (textField.text.length == 8 || textField.text.length == 17){
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
        }
        return YES;
    } else {
        if (textField.text.length == 6 || textField.text.length == 15){//开头6个字母  末尾4个
            textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
        }
        if ([toBeString length] >= 20){
            toBeString = [toBeString substringToIndex:20];// 共13位
            textField.text = toBeString;
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - 手机号加空格  153 3925 5159
+ (BOOL)formatPhoneNoWithTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if ([string isEqualToString:@""]) { // 删除字符
        if (textField.text.length % 5 == 0 && textField.text.length < 11){
            textField.text = [textField.text substringToIndex:textField.text.length - 1];
        }
        return YES;
    } else {
        if (textField.text.length % 5 == 3 && textField.text.length < 11){//开头3个字母 4个一空
            textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
        }
        if ([toBeString length] >= 13){
            toBeString = [toBeString substringToIndex:13];// 共13位
            textField.text = toBeString;
            return NO;
        }
    }
    return YES;
}
//字典转string
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//去空格
+ (NSString *)deleteStr:(NSString *)string{
    NSString *str = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    return str;
}
//获得16位的随机数作为AES加密秘钥
+ (NSString *)getRandomKey {
    
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    // Get the characters into a C array for efficient shuffling
    NSUInteger numberOfCharacters = [alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
    
    // Perform a Fisher-Yates shuffle
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        NSUInteger j = (arc4random_uniform((float)numberOfCharacters - i) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    
    
    // Turn the result back into a string
    //        NSString *result = [NSString stringWithCharacters:characters length:16];
    
    NSData *str = [[NSData alloc] initWithBytes:characters length:16];
    NSString* str1 = [NSString base64StringFromData:str length:[str length]];
    free(characters);
    
    return str1;
}

#pragma 正则匹配用户密码6-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

+ (void)addAlumByController:(UIViewController *)controller delegate:(id)delegage {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = delegage;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *take_photo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [controller presentViewController:picker animated:YES completion:nil];
        }
    }];
    UIAlertAction *anblum = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            [controller presentViewController:picker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:take_photo];
    [alertController addAction:anblum];
    [controller presentViewController:alertController animated:YES completion:nil];
    
}

+ (void)addAlumByController:(UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate> *)controller indexPath:(NSIndexPath * )indexPath{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = controller;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *take_photo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [controller presentViewController:picker animated:YES completion:nil];
        }
    }];
    UIAlertAction *anblum = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            [controller presentViewController:picker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:cancel];
    [alertController addAction:take_photo];
    [alertController addAction:anblum];
    [controller presentViewController:alertController animated:YES completion:nil];
}

+ (NSString *)seperateTimeWithPoint:(NSString *)timeString {
    NSString *year = [timeString substringToIndex:4];
    NSString *month = [timeString substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [timeString substringFromIndex:6];
    
    NSString *formatterTime = [NSString stringWithFormat:@"%@.%@.%@",year,month,day];
    return formatterTime;
}

////////////////////////////////////  给textF添加逗号  ////////////////////////////
+ (NSString *)formarText:(NSString*)text withString:(NSString*)string{
    NSString *str;
    if ([text containsString:@"."] || [string isEqualToString:@"."]) {
        return text;
    }
    text = [text stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    if (![string isEqualToString:@""]) {//添加字符
        str = [DHCCToolsMethod addChars:text];
        
    }else{//删除字符
        str = [DHCCToolsMethod removeChars:text];
    }
    return str;
    
}


//删除字符
+ (NSString*)removeChars:(NSString*)string{
    NSMutableString *aString = [[NSMutableString alloc]initWithCapacity:string.length];
    if (string.length>=4) {
        NSString *charts = [string substringWithRange:NSMakeRange(string.length-4, 4)];
        [aString insertString:charts atIndex:0];
        if (string.length>4) {
            [aString insertString:@"," atIndex:0];
        }
        NSString *subString = [string substringToIndex:string.length-4];
        
        while (subString.length>3) {
            NSString *abc = [subString substringFromIndex:subString.length-3];
            subString = [subString substringToIndex:subString.length-3];
            [aString insertString:abc atIndex:0];
            [aString insertString:@"," atIndex:0];
        }
        [aString insertString:subString atIndex:0];
        
    }else{
        NSInteger count = [string length];
        for (NSInteger i = count; i > 0; i--) {
            NSString *charts = [string substringWithRange:NSMakeRange(i-1, 1)];
            [aString insertString:charts atIndex:0];
        }
    }
    return aString;
}
//添加字符
+ (NSString*)addChars:(NSString*)string{
    NSMutableString *aString = [[NSMutableString alloc]initWithCapacity:string.length];
    if (string.length>=3) {
        NSString *charts = [string substringWithRange:NSMakeRange(string.length-2, 2)];
        [aString insertString:charts atIndex:0];
        [aString insertString:@"," atIndex:0];
        NSString *subString = [string substringToIndex:string.length-2];
        
        while (subString.length>3) {
            NSString *abc = [subString substringFromIndex:subString.length-3];
            subString = [subString substringToIndex:subString.length-3];
            [aString insertString:abc atIndex:0];
            [aString insertString:@"," atIndex:0];
        }
        [aString insertString:subString atIndex:0];
        
    }else{
        NSInteger count = [string length];
        for (NSInteger i = count; i > 0; i--) {
            NSString *charts = [string substringWithRange:NSMakeRange(i-1, 1)];
            [aString insertString:charts atIndex:0];
        }
    }
    return aString;
}
////////////////////////////////////////////////////////////////

// == 秦氏添加逗号大法
+ (NSString *)addCharForString:(NSString *)str textFiled:(UITextField *)textFiled{
    NSString *tempStr = str;
    NSArray *strArr = [str componentsSeparatedByString:@"."];
    NSString *leftStr = strArr[0];  //小数点左边的部分
    leftStr = [leftStr stringByReplacingOccurrencesOfString:@"," withString:@""]; //将小数点左边的部分去逗号
    
    //如果小数点左边的位数超过9位，则恢复字符串
    if (leftStr.length > 9) {
        tempStr = [self resetForString:str textFiled:textFiled];
        leftStr = [tempStr componentsSeparatedByString:@"."][0];
        leftStr = [leftStr stringByReplacingOccurrencesOfString:@"," withString:@""]; //回复后要重新去掉逗号，否则下面无法利用NSNumberFormatter进行逗号“格式化”
    }
    
    //利用NSNumberFormatter重新加入逗号
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    leftStr = [numberFormatter stringFromNumber:@([leftStr doubleValue])];
    
    if (strArr.count == 1) {  //如果没有小数点，直接返回左边字符串
        
        return leftStr;
    }else {  //如果有，则判断右边字符串是nil还是非nil,是nil时要置为@""
        NSString *rightStr = strArr[1] == nil ? @"" : strArr[1];
        
        if (((NSString *)strArr[1]).length > 2) {  //判断是否小数点后超过了两位，如果超过，则恢复字符串
            tempStr = [self resetForString:str textFiled:textFiled];
            rightStr = [tempStr componentsSeparatedByString:@"."][1];
        }
        NSString *result = [NSString stringWithFormat:@"%@.%@",leftStr,rightStr];
        return result;
    }
}
//恢复字符串到输入前的状态
+ (NSString *)resetForString:(NSString *)str textFiled:(UITextField *)textFiled{
    NSInteger location = [textFiled selectedRange].location;
    NSString *leftStr = [textFiled.text substringToIndex:location];
    NSString *rightStr = [textFiled.text substringFromIndex:location];
    leftStr = [leftStr substringToIndex:(leftStr.length - 1)];
    NSString *result = [NSString stringWithFormat:@"%@%@",leftStr,rightStr];
    return result;
}

@end

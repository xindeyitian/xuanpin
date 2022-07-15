//
//  THHttpConfig_h.h
//
//  Created by Mac on 2017/1/24.
//  Copyright © 2017年 Mac. All rights reserved.
//

#ifndef THHttpConfig_h
#define THHttpConfig_h

//正式
//#define XTAppBaseURL          @"http://192.168.1.113:8099/supply/"//正式服
#define XTAppBaseURL          @"http://tpi.tuanhuoit.com/supply/"//测试服
#define XTAppBaseUseURL          @"https://tpi.tuanhuoit.com/user/"//测试服

//宏定义封装一下

#define THToken               [THAPPService shareAppService].token
#define THAppVersion          @"4.3"
#define THIOS                 @"iOS"
#define THCHANNELNUM          @"AppStore"
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#pragma mark - ——————— 支付状态 ————————
// 微信
#define LNotification_WXChatPaySuccess @"LNotification_WXChatPaySuccess"
#define LNotification_WXChatPayFailed @"LNotification_WXChatPayFailed"
// 支付宝
#define LNotification_AliPaySuccess @"LNotification_AliPaySuccess"
#define LNotification_AliPayFailed @"LNotification_AliPayFailed"

#define UMShareKey @"6169135314e22b6a4f23635c"

#define THTimeOutInterval     5

typedef enum {
    
       THRequestStatusOK =   0,
       THRequestStatusError = 1
 
    
}THRequestStatus;


#endif /* THHttpConfig_h */


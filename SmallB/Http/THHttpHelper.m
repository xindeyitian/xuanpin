//
//  THHttpHelper.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/1/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "THHttpHelper.h"
#import "THAPPService.h"
#import "MBProgressHUD.h"
#import "THHttpManager.h"
#import <MJExtension.h>
#import "ZbankGetDeviceTypeTool.h"



@implementation THHttpHelper
/**
 3.2账号密码登录

 @param phone 手机号
 @param passWord 密码
 @param block 回传数据
 */
+ (void)requestLoginWithPhone:(NSString *)phone PassWord:(NSString *)passWord block:(void (^)(NSInteger returnCode,THRequestStatus status,THUserModel *user))block
{
//    NSString *strUrl = userlogin;
//
//    NSDictionary *dic = @{
//                          @"userAccount":phone,
//                          @"userPassword":passWord,
//                          @"phoneName": [ZbankGetDeviceTypeTool getDeviceType],
//                          @"versionCode" : [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
//                          @"phoneVersion" : [[UIDevice currentDevice] systemVersion]
//                          };
//
//    [THHttpManager POST:strUrl parameters:dic isSecret:allIsSecret dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
//
//        THUserModel *user = nil;
//
//        if (status == THRequestStatusOK) {
//
//            user = [THUserModel mj_objectWithKeyValues:data];
//        }
//
//        if (block) {
//
//            block(returnCode,status,user);
//        }
//    }];
}
+ (void)requestLoginWithPhone:(NSString *)phone SmsCode:(NSString *)smsCode block:(void (^)(NSInteger returnCode,THRequestStatus status,THUserModel *user))block{
    
//    NSString *strUrl = phoneLogin;
//
//    NSDictionary *dic = @{
//                          @"userAccount":phone,
//                          @"code":smsCode,
//                          @"phoneName": [ZbankGetDeviceTypeTool getDeviceType],
//                          @"versionCode" : [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
//                          @"phoneVersion" : [[UIDevice currentDevice] systemVersion]
//                          };
//
//    [THHttpManager POST:strUrl parameters:dic isSecret:allIsSecret dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
//
//        THUserModel *user = nil;
//
//        if (status == THRequestStatusOK) {
//
//            user = [THUserModel mj_objectWithKeyValues:data];
//        }
//
//        if (block) {
//
//            block(returnCode,status,user);
//        }
//    }];
}
+ (void)getVerificationCodeWithPhone:(NSString *)phone block:(void (^)(NSInteger returnCode,THRequestStatus status))block{
    
//    NSString *strUrl = sendSms;
//
//    NSDictionary *dic = @{@"userAccount":phone};
//
//    [THHttpManager POST:strUrl parameters:dic isSecret:allIsSecret dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
//        if (block) {
//
//            block(returnCode,status);
//        }
//    }];
}

//找回密码
+ (void)PasswordRetrieval:(NSString *)phone
            confirmNewPwd:(NSString *)confirmNewPwd
                     code:(NSString *)code
                     PassWord:(NSString *)password
                    block:(void (^)(NSInteger returnCode,THRequestStatus status))block
{
//    NSString *strUrl = updateUserPwd;
//
//    NSDictionary *dic = @{
//                          @"userAccount":phone,
//                          @"confirmNewPwd":confirmNewPwd,
//                          @"randomCode":code,
//                          @"NewPwd":password
//                          };
//    [THHttpManager POST:strUrl parameters:dic isSecret:allIsSecret dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
//        if (block) {
//
//            block(returnCode,status);
//        }
//    }];
}

+ (void)registUserWithSmsCode:(NSString *)code
           andOldUserPassword:(NSString *)oldUserPassword
              andReferralCode:(NSString *)referralCode
              andUserPassword:(NSString *)userPassword
                 andUserPhone:(NSString *)userPhone
                        block:(void (^)(NSInteger returnCode,THRequestStatus status))block{
    
//    NSString *strUrl = userRegister;
//
//    NSDictionary *dic = @{
//                          @"code":code,
//                          @"oldUserPassword":oldUserPassword,
//                          @"referralCode":referralCode,
//                          @"userPassword":userPassword,
//                          @"userAccount":userPhone,
//                          };
//
//    [THHttpManager POST:strUrl parameters:dic isSecret:allIsSecret dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
//
//        if (status == THRequestStatusOK) {
//
//
//        }
//
//        if (block) {
//
//            block(returnCode,status);
//        }
//    }];
}
+ (void)updateuserAccountWithNewuserAccount:(NSString *)newuserAccount
                              AndRandomCode:(NSString *)randomCode
                             AndUserAccount:(NSString *)userAccount
                                      Block:(void (^)(NSInteger returnCode,THRequestStatus status))block{
    
//    NSString *strUrl = updateuserAccount;
//
//    NSDictionary *dic = @{
//                          @"newuserAccount":newuserAccount,
//                          @"randomCode":randomCode,
//                          @"userAccount":userAccount,
//                          };
//
//    [THHttpManager POST:strUrl parameters:dic isSecret:allIsSecret dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
//
//        if (status == THRequestStatusOK) {
//
//
//        }
//
//        if (block) {
//
//            block(returnCode,status);
//        }
//    }];
}

@end

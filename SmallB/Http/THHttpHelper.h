//
//  THHttpHelper.h
//
//  Created by Mac on 2017/1/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THHttpConfig.h"
#import "THUserModel.h"
@interface THHttpHelper : NSObject


/**
 3.2账号密码登录
 
 @param phone 手机号
 @param passWord 密码
 @param block 回传数据
 */
+ (void)requestLoginWithPhone:(NSString *)phone PassWord:(NSString *)passWord block:(void (^)(NSInteger returnCode,THRequestStatus status,THUserModel *user))block;


/// 验证码登陆
/// @param phone 手机号
/// @param smsCode 验证码
/// @param block 回调
+ (void)requestLoginWithPhone:(NSString *)phone SmsCode:(NSString *)smsCode block:(void (^)(NSInteger returnCode,THRequestStatus status,THUserModel *user))block;

//获取验证码
+ (void)getVerificationCodeWithPhone:(NSString *)phone block:(void (^)(NSInteger returnCode,THRequestStatus status))block;


//找回密码
+ (void)PasswordRetrieval:(NSString *)phone
            confirmNewPwd:(NSString *)confirmNewPwd
                     code:(NSString *)code
                 PassWord:(NSString *)password
                    block:(void (^)(NSInteger returnCode,THRequestStatus status))block;

//注册
+ (void)registUserWithSmsCode:(NSString *)code
           andOldUserPassword:(NSString *)oldUserPassword
              andReferralCode:(NSString *)referralCode
              andUserPassword:(NSString *)userPassword
                 andUserPhone:(NSString *)userPhone
                        block:(void (^)(NSInteger returnCode,THRequestStatus status))block;
+ (void)updateuserAccountWithNewuserAccount:(NSString *)newuserAccount
                              AndRandomCode:(NSString *)randomCode
                             AndUserAccount:(NSString *)userAccount
                                      Block:(void (^)(NSInteger returnCode,THRequestStatus status))block;
@end

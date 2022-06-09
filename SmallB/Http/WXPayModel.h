//
//  WXPayModel.h
//  CreditManager
//
//  Created by 李经纬 on 2018/4/23.
//  Copyright © 2018年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXPayModel : NSObject


/** 绑定支付的APPID*/
@property (nonatomic, copy) NSString *appid;
/** appSecret*/
@property (nonatomic, copy) NSString *w_appsecret;
/** 商户号*/
@property (nonatomic, copy) NSString *mchid;
/** 随机字符串*/
@property (nonatomic, copy) NSString *noncestr;
/** 扩展字段*/
@property (nonatomic, copy) NSString *package;
/** 加密后密文*/
@property (nonatomic, copy) NSString *sign;
/** 预支付交易会话ID*/
@property (nonatomic, copy) NSString *prepayid;
/** 时间戳*/
@property (nonatomic, copy) NSString *timestamp;
/** 订单号*/
@property (nonatomic, copy) NSString *order;



@end

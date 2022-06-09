//
//  BankManager.h
//  ZhongbenKaGuanJia
//
//  Created by 李经纬 on 2018/8/25.
//  Copyright © 2018年 李经纬. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BankInfoModel;

@interface BankManager : NSObject

+ (instancetype)sharedBankManager;
/**
 根据bankCode获取银行信息
 */
- (BankInfoModel *)getBankInfoModelWithBankCode:(NSString *)bankCode;

@end

@interface BankInfoModel : NSObject
@property (nonatomic, copy) NSString *bankName;
@property (nonatomic, copy) NSString *bankCode;
@property (nonatomic, copy) NSString *showColor;
@property (nonatomic, copy) NSString *bankLogo_name;
@property (nonatomic, copy) NSString *bankLogo;
@property (nonatomic, copy) NSString *bankWatermark;
@end

//
//  BankManager.m
//  ZhongbenKaGuanJia
//
//  Created by 李经纬 on 2018/8/25.
//  Copyright © 2018年 李经纬. All rights reserved.
//

#import "BankManager.h"

#import "MJExtension.h"

@interface BankManager()
@property (nonatomic, strong) NSMutableDictionary *dataDict;

@end

@implementation BankManager

+ (instancetype)sharedBankManager{
        static dispatch_once_t onceToken;
        static BankManager *instance;
        dispatch_once(&onceToken, ^{
            instance = [[BankManager alloc] init];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BankInfo" ofType:@"plist"];
            NSDictionary *data1 = [[NSDictionary alloc] initWithContentsOfFile:filePath];
            instance.dataDict = [NSMutableDictionary dictionaryWithDictionary:data1[@"data"]];
        });
        return instance;
}


/**
 根据bankCode获取银行信息
 */
- (BankInfoModel *)getBankInfoModelWithBankCode:(NSString *)bankCode{
    BankInfoModel *bankInfoModel;
    NSString *bankCodeStr = [bankCode lowercaseStringWithLocale:[NSLocale currentLocale]];
    if (![[self.dataDict allKeys] containsObject:bankCodeStr]) {
        NSDictionary *dict = self.dataDict[@"default"];
        bankInfoModel = [BankInfoModel mj_objectWithKeyValues:dict];
        bankInfoModel.bankLogo_name = [NSString stringWithFormat:@"logo_%@", @"default"];
        bankInfoModel.bankLogo = [NSString stringWithFormat:@"logo2_%@", @"default"];
    }else{
        NSDictionary *dict = self.dataDict[bankCodeStr];
        bankInfoModel = [BankInfoModel mj_objectWithKeyValues:dict];
        bankInfoModel.bankLogo_name = [NSString stringWithFormat:@"logo_%@", bankInfoModel.bankCode];
        bankInfoModel.bankLogo = [NSString stringWithFormat:@"logo2_%@", bankInfoModel.bankCode];
    }
    return bankInfoModel;
}

@end

@implementation BankInfoModel
@end

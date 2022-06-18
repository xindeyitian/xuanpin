//
//  YinsiFuwuViewController.h
//  SeaEgret
//
//  Created by MAC on 2021/7/16.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PrivacyAgreementType) {
    PrivacyAgreementTypeLogin = 1,
    PrivacyAgreementTypeRegist,
    PrivacyAgreementTypeUser,
    PrivacyAgreementTypePrivacyAgreement,
    PrivacyAgreementTypeShiMing,
    PrivacyAgreementTypeSupplier
};

@interface YinsiFuwuViewController : THBaseViewController

@property (assign, nonatomic) NSInteger type;//1:服务  2:隐私 3:海鹭跨境用户行为公 4:用户使用许可协议
@property (assign, nonatomic) PrivacyAgreementType agreeType;

@end

NS_ASSUME_NONNULL_END

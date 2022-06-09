//
//  MyInfoModel.h
//  SmallB
//
//  Created by zhang on 2022/5/3.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyInfoModel : THBaseModel

@property (nonatomic , copy)NSString *realName;
@property (nonatomic , copy)NSString *ifAuth;//是否实名 0未实名,1已实名
@property (nonatomic , copy)NSString *sex;//性别，默认0，男1，女2
@property (nonatomic , copy)NSString *cityName;
@property (nonatomic , copy)NSString *serviceTel;
@property (nonatomic , copy)NSString *provinceCode;
@property (nonatomic , copy)NSString *cityCode;
@property (nonatomic , copy)NSString *avatar;
@property (nonatomic , copy)NSString *userId;
@property (nonatomic , copy)NSString *phoneNum;
@property (nonatomic , copy)NSString *birthDay;
@property (nonatomic , copy)NSString *provinceName;
@property (nonatomic , copy)NSString *areaName;
@property (nonatomic , copy)NSString *areaCode;
@property (nonatomic , copy)NSString *shiming;

@property (nonatomic , copy)NSString *isPassword;//是否设置密码
@property (nonatomic , copy)NSString *bindAli;//是否绑定支付宝 0否,1是
@property (nonatomic , copy)NSString *bindWechat;//是否绑定微信 0否,1是


@end

NS_ASSUME_NONNULL_END

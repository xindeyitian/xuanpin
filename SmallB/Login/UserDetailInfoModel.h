//
//  UserDetailInfoModel.h
//  SmallB
//
//  Created by zhang on 2022/5/3.
//

#import "THBaseModel.h"
@class UserDetailInfoLoginUserVoModel;
NS_ASSUME_NONNULL_BEGIN

@interface UserDetailInfoModel : THBaseModel

@property(nonatomic,strong)UserDetailInfoLoginUserVoModel *LoginUserVo;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *timestamp;

@end

@interface UserDetailInfoLoginUserVoModel : THBaseModel

@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *storeDisplayType;
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *djlsh;
@property(nonatomic,strong)NSString *provinceCode;
@property(nonatomic,strong)NSString *cityCode;
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *phoneNum;
@property(nonatomic,strong)NSString *areaName;
@property(nonatomic,strong)NSString *provinceName;
@property(nonatomic,strong)NSString *shopId;
@property(nonatomic,strong)NSString *areaCode;
@property(nonatomic,strong)NSString *inviteCode;

@end


NS_ASSUME_NONNULL_END

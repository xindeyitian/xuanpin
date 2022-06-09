//
//  THUserModel.h
//  LLWFan
//
//  Created by MAC on 2022/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THUserModel : NSObject<NSCoding,NSSecureCoding>

/**
 住户主键
 */
@property (nonatomic,copy) NSString * userDetailsKey;
/**
 用户账号（手机号）
 */
@property (nonatomic,copy) NSString * userAccount;
/**
 登录密码
*/
@property (nonatomic,copy) NSString * userPassword;
@property (nonatomic,copy) NSString * createTime;//创建时间
@property (nonatomic,copy) NSString * userPortrait;//用户头像
@property (nonatomic,copy) NSString * userHailuId;//海鹭ID
@property (nonatomic,copy) NSString * updateTime;//修改时间
@property (nonatomic,copy) NSString * userNickName;//用户昵称
@property (nonatomic,copy) NSString * personalSignature;//个性签名
@property (nonatomic,copy) NSString * recommendKey;//推荐人主键
@property (nonatomic,copy) NSString * sessionId;
@property (nonatomic,copy) NSString * sessionTime;//会话时间（登陆时间）
@property (nonatomic,copy) NSString * userPayPassword;//支付密码
@property (nonatomic,copy) NSString * userBirthday;//用户生日（0101）
@property (nonatomic,copy) NSString * userRegion;//所在地
@property (nonatomic,copy) NSString * followUserKey;//关注用户主键 只能在关注列表里用

@property (nonatomic, assign) NSInteger fansOrAtt;//粉丝或关注
@property (nonatomic,assign) NSInteger isRealName;//是否实名 1是 2否
@property (nonatomic, assign) NSInteger followersCount;//粉丝数
@property (nonatomic, assign) NSInteger isNaN;//是否关注 0.未关注 1.已关注
@property (nonatomic, assign) NSInteger isAnchor;//是否可直播 1.不能直播 2.可直播


/// 身份证
@property (nonatomic, assign) NSInteger realIdCard;
/// 用户等级 1.会员 2.运营官
@property (nonatomic, assign) NSInteger userLevel;
/// 折扣价格 根据等级后台直接返回的在每一个金额那里乘一下
@property (nonatomic, copy) NSString *discountPrice;


/**
 用户类型（1.用户 2.会员）
 */
@property (nonatomic,assign) NSInteger userType;
/**
 用户性别（1.男 2.女）
 */
@property (nonatomic,assign) NSInteger userSex;


@end

NS_ASSUME_NONNULL_END

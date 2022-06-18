//
//  StoreManagerModel.h
//  SmallB
//
//  Created by zhang on 2022/5/12.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreManagerModel : THBaseModel

@property(nonatomic,copy)NSString *bgImgUrl;
@property(nonatomic,copy)NSString *cityName;
@property(nonatomic,copy)NSString *logoImgUrl;
@property(nonatomic,copy)NSString *provinceCode;
@property(nonatomic,copy)NSString *shouchiImage;
@property(nonatomic,copy)NSString *cityCode;
@property(nonatomic,copy)NSString *shopDesc;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *areaName;
@property(nonatomic,copy)NSString *shopId;
@property(nonatomic,copy)NSString *provinceName;
@property(nonatomic,copy)NSString *shopName;
@property(nonatomic,copy)NSString *areaCode;

@property(nonatomic,copy)NSString *idCardPath;
@property(nonatomic,copy)NSString *idCardHand;
@property(nonatomic,copy)NSString *idCardFront;
@property(nonatomic,copy)NSString *idCardBack;
@property(nonatomic,copy)NSString *realName;

@property(nonatomic,copy)NSString *urlPath;
@property(nonatomic,copy)NSString *bucket;

@end

NS_ASSUME_NONNULL_END

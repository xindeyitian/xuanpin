//
//  StoreModel.h
//  SmallB
//
//  Created by zhang on 2022/5/10.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreModel : THBaseModel

@property (nonatomic , copy)NSString *collectCount;//
@property (nonatomic , copy)NSString *stars;//
@property (nonatomic , copy)NSString *supplyName;//
@property (nonatomic , copy)NSString *supplyId;//
@property (nonatomic , copy)NSString *logImgUrl;//
@property (nonatomic , copy)NSString *bgImgUrl;//
@property (nonatomic , copy)NSString *urlPath;
@property (nonatomic , copy)NSString *afterSaleValue;//售后评分
@property (nonatomic , copy)NSString *appraisalValue;//评价评分
@property (nonatomic , copy)NSString *areaName;//
@property (nonatomic , copy)NSString *cityName;//
@property (nonatomic , copy)NSString *goodsCount;//
@property (nonatomic , copy)NSString *createTime;//
@property (nonatomic , copy)NSString *isCollect;//是否收藏 1已收藏,2未收藏
@property (nonatomic , copy)NSString *logisticsValue;//物流评分
@property (nonatomic , copy)NSString *provinceName;//

@end

NS_ASSUME_NONNULL_END

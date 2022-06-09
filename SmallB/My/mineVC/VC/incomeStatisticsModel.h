//
//  incomeStatisticsModel.h
//  SmallB
//
//  Created by zhang on 2022/5/3.
//

#import "THBaseModel.h"
@class incomeStaVoModel,behaviorStaVoModel;
NS_ASSUME_NONNULL_BEGIN

@interface incomeStatisticsModel : THBaseModel

//@property (nonatomic , copy)NSMutableArray *orderStaVo;
@property (nonatomic , strong)incomeStaVoModel *incomeStaVo;
@property (nonatomic , strong)behaviorStaVoModel *behaviorStaVo;

@end

@interface incomeStaVoModel : THBaseModel

@property (nonatomic , assign)float operableIncome;//可提现金额
@property (nonatomic , copy)NSString *totalIncome;//店铺累计收入
@property (nonatomic , copy)NSString *pendingIncome;//待结算收益

@end

@interface behaviorStaVoModel : THBaseModel

@property (nonatomic , copy)NSString *cookies;//浏览记录数量
@property (nonatomic , copy)NSString *attentionShop;//店铺关注数量
@property (nonatomic , copy)NSString *collectGoods;//商品收藏数量

@end

NS_ASSUME_NONNULL_END

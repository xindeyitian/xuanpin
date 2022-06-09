//
//  MingXiRecordModel.h
//  SmallB
//
//  Created by zhang on 2022/5/16.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MingXiRecordModel : THBaseModel

@property(nonatomic , strong)NSMutableArray *records;

@end

@interface MingXiRecordListModel : THBaseModel

@property(nonatomic , copy)NSString *changeTime;
@property(nonatomic , copy)NSString *goodsName;
@property(nonatomic , copy)NSString *logId;//流水号
@property(nonatomic , copy)NSString *moneyChange;
@property(nonatomic , copy)NSString *orderNo;
@property(nonatomic , copy)NSString *shopOrderItemId;

@end

NS_ASSUME_NONNULL_END

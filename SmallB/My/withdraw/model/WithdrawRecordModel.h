//
//  WithdrawRecordModel.h
//  SmallB
//
//  Created by zhang on 2022/5/16.
//

#import "THBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawRecordModel : THBaseModel

@property(nonatomic , strong)NSMutableArray *records;

@end

@interface WithdrawRecordListModel : THBaseModel

@property(nonatomic , copy)NSString *applyTime;//申请时间
@property(nonatomic , copy)NSString *arrivalTime;//到账时间
@property(nonatomic , copy)NSString *dealDesc;//处理描述
@property(nonatomic , copy)NSString *dealSign;//0待审核 1已处理 9已提现 -1提现失败
@property(nonatomic , copy)NSString *moneyValue;//提现积分
@property(nonatomic , copy)NSString *withdrawName;//提现名称
@property(nonatomic , copy)NSString *accountType;

@end

NS_ASSUME_NONNULL_END

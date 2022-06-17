//
//  MyVCInfoTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/7.
//

#import "ThBaseTableViewCell.h"
#import "incomeStatisticsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyVCInfoTableViewCell : ThBaseTableViewCell

@property(nonatomic,strong)void(^btnClickBlock)(NSInteger index);
@property(nonatomic,strong)incomeStatisticsModel *model;
@property(nonatomic,strong)userInfoModel *infoModel;
@end

NS_ASSUME_NONNULL_END

@interface MyVCChatTableViewCell : ThBaseTableViewCell

@end

@interface MyVCOrderTableViewCell : ThBaseTableViewCell

@end

@interface MyVCProfitsTableViewCell : ThBaseTableViewCell

@property(nonatomic,strong)incomeStatisticsModel *model;


@end

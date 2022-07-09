//
//  myOrderListContentTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "ThBaseTableViewCell.h"
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface myOrderListContentTableViewCell : ThBaseTableViewCell

@property(nonatomic , strong)UILabel *productTitleL;
@property(nonatomic , strong)OrderListProductModel *model;

@end

@interface myOrderListContentCellHeadView : UIView

@property(nonatomic,strong)void(^viewClickBlock)(void);
@property(nonatomic , strong)OrderListRecordsModel *model;

@end

@interface myOrderListContentCellFootView : UIView

@property(nonatomic,strong)void(^viewClickBlock)(void);
@property(nonatomic , strong)OrderListRecordsModel *model;
@property (nonatomic ,assign)NSInteger type;//1 云仓 2自营

@end

NS_ASSUME_NONNULL_END

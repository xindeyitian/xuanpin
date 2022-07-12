//
//  myOrderListContentTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "ThBaseTableViewCell.h"
#import "OrderListModel.h"
#import "OrderShouHouListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface myOrderListContentTableViewCell : ThBaseTableViewCell

@property(nonatomic , strong)UILabel *productTitleL;
@property(nonatomic , strong)OrderListProductModel *model;
@property(nonatomic , strong)OrderShouHouListRecordsModel *shouHouModel;

@end

@interface myOrderListContentCellHeadView : UIView

@property(nonatomic,strong)void(^viewClickBlock)(void);
@property(nonatomic , strong)OrderListRecordsModel *model;
@property(nonatomic , strong)OrderShouHouListRecordsModel *shouHouModel;

@end

@interface myOrderListContentCellFootView : UIView

@property(nonatomic,strong)void(^viewClickBlock)(void);
@property(nonatomic , strong)OrderListRecordsModel *model;
@property (nonatomic ,assign)NSInteger type;//1 云仓 2自营
@property(nonatomic , strong)OrderShouHouListRecordsModel *shouHouModel;

@end

NS_ASSUME_NONNULL_END

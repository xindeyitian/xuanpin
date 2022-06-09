//
//  MyOrderListZiYingTableViewCell.h
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "ThBaseTableViewCell.h"
#import "myOrderViewController.h"
#import "OrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyOrderListZiYingTableViewCell : ThBaseTableViewCell

@property(nonatomic , strong)UILabel *productTitleL;
@property(nonatomic , strong)OrderListProductModel *model;

@end

@interface myOrderListZiYingCellHeadView : UIView

@property(nonatomic,strong)void(^viewClickBlock)(void);
@property(nonatomic , strong)OrderListRecordsModel *model;

@end

@interface myOrderListZiYingCellFootView : UIView

@property(nonatomic,strong)void(^viewClickBlock)(void);
@property (nonatomic ,assign)myOrderType orderType;
@property(nonatomic , strong)OrderListRecordsModel *model;

@end

NS_ASSUME_NONNULL_END


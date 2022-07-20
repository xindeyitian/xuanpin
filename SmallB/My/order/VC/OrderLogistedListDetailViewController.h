//
//  OrderLogistedListDetailViewController.h
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "THBaseTableViewController.h"
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderLogistedListDetailViewController : THBaseTableViewController

@property (nonatomic , strong)OrderDetailModel *detailModel;
@property (nonatomic , copy)NSString *orderID;

@end

NS_ASSUME_NONNULL_END

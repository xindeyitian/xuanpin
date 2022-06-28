//
//  myOrderViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/8.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, myOrderType) {
    myOrderTypeWaitingAllOrder = 0,//全部
    myOrderTypeWaitingPaid,//待付款
    myOrderTypeWaitingToBeDelivered,//待发货
    myOrderTypeWaitingPendingReceipt,//待收货
    myOrderTypeWaitingRefund,//退款/售后
    myOrderTypeWaitingComplete,//已完成
};

@interface myOrderViewController : THBaseViewController

@property (nonatomic ,assign)myOrderType orderType;

@end

NS_ASSUME_NONNULL_END

//
//  CancelOrderAlertViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, orderAlertType) {
    orderAlertType_CancelOrder = 0,//取消订单
    orderAlertType_AgreeRefund,//确定同意退款
    orderAlertType_NotAgreeRefund,//不同意退款
    orderAlertType_AgreeRefunds,//确定同意退货退款
    orderAlertType_NotAgreeRefunds,//不同意退货退款
};

@interface OrderAlertViewController : BaseAlertViewController

@property (nonatomic , assign)orderAlertType alertType;
@property (nonatomic , copy)NSString *orderID;

@end

NS_ASSUME_NONNULL_END

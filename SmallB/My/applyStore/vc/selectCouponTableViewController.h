//
//  selectCouponTableViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/16.
//

#import "THBaseTableViewController.h"
@class CouponListModel,CouponListVosModel;

NS_ASSUME_NONNULL_BEGIN

@interface selectCouponTableViewController : THBaseTableViewController

@property(nonatomic,strong)void(^viewClickBlock)(CouponListVosModel *model);
@property(nonatomic,strong)NSMutableArray *couponAry;
@property(nonatomic,strong)CouponListVosModel *selectModel;

@end

NS_ASSUME_NONNULL_END

//
//  OrderLogistCompanyViewController.h
//  SmallB
//
//  Created by zhang on 2022/7/6.
//

#import "THBaseTableViewController.h"
#import "OrderLogistCompanyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderLogistCompanyViewController : THBaseTableViewController

@property (nonatomic , strong)void(^selectBlock)(OrderLogistCompanyModel *model);

@end

NS_ASSUME_NONNULL_END

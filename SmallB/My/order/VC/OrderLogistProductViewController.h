//
//  OrderLogistProductViewController.h
//  SmallB
//
//  Created by zhang on 2022/7/7.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderLogistProductViewController : THBaseTableViewController

@property (nonatomic , strong)NSMutableArray *productAry;
@property (nonatomic , strong)NSMutableArray *allListAry;
@property (nonatomic , assign)NSInteger section;
@property (nonatomic , strong)void(^selectBlock)(NSMutableArray *productAry);

@end

NS_ASSUME_NONNULL_END

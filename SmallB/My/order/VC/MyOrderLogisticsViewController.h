//
//  MyOrderLogisticsViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderLogisticsViewController : THBaseTableViewController

@property (nonatomic , assign)BOOL haveBottom;
@property (nonatomic , copy)NSString *orderID;
@property (nonatomic , strong)NSMutableArray *productAry;
@property(nonatomic,strong)void(^successBlock)(void);

@end

NS_ASSUME_NONNULL_END

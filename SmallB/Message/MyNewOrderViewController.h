//
//  FirstViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "THBaseTableViewController.h"
#import "myOrderViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyNewOrderViewController : THBaseTableViewController

@property (nonatomic ,assign)NSInteger index;
@property (nonatomic ,assign)myOrderType orderType;
@property (nonatomic ,assign)BOOL isShouhou;

@end

NS_ASSUME_NONNULL_END

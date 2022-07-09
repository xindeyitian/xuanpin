//
//  SecondViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/27.
//

#import "THBaseTableViewController.h"
#import "myOrderViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyOrderTypeViewController : THBaseTableViewController<JXCategoryListContentViewDelegate>

@property (nonatomic ,assign)NSInteger type;//1 云仓 2自营
@property (nonatomic ,assign)myOrderType orderType;
@property (nonatomic ,assign)BOOL isShouhou;
@property (nonatomic ,assign)NSInteger index;

@end

NS_ASSUME_NONNULL_END

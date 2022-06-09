//
//  BuyTuanCodeViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/19.
//

#import "THBaseTableViewController.h"
@class BuyTuanModel;

NS_ASSUME_NONNULL_BEGIN

@interface BuyTuanCodeViewController : THBaseTableViewController

@end

@interface priceInfoBtn : UIButton

@property (nonatomic , assign)NSInteger isSelected;
@property (nonatomic , strong)BuyTuanModel *model;

@end

@interface numAddReduceView : UIView

@property (nonatomic , strong)void(^numChangeBlock)(NSInteger num);

@end

NS_ASSUME_NONNULL_END

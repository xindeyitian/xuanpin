//
//  myShimingViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface myShimingViewController : THBaseTableViewController

@property (nonatomic , strong)void(^shimingSuccessBlock)(void);

@end

NS_ASSUME_NONNULL_END

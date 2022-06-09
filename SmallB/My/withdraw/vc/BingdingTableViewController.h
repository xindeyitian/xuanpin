//
//  BingdingTableViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/15.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BingdingTableViewController : THBaseTableViewController

@property (nonatomic , assign)NSInteger index;
@property (nonatomic , strong)void(^viewBlock)(void);

@end

NS_ASSUME_NONNULL_END

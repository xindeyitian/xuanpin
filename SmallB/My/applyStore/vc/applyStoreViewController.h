//
//  applyStore ViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/16.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface applyStoreViewController : THBaseTableViewController

@property (nonatomic , assign)BOOL isEdit;//是否是编辑状态
@property (nonatomic , copy)NSString *token;
@property (nonatomic , assign)NSInteger typeIndex;
@property (nonatomic , assign)NSInteger ifShow;
@property (nonatomic , strong)void(^viewBlock)(void);

@end

NS_ASSUME_NONNULL_END

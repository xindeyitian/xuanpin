//
//  withdrawResultViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/13.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface withdrawResultViewController : THBaseViewController

@property (nonatomic , copy)NSString *money;
@property (nonatomic , copy)NSString *typeStr;
@property (nonatomic , strong)void(^viewBlock)(void);

@end

NS_ASSUME_NONNULL_END

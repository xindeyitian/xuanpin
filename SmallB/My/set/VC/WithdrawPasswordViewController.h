//
//  WithdrawPasswordViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "THBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawPasswordViewController : THBaseTableViewController

@property (nonatomic , assign)BOOL isEdit;
@property (nonatomic , strong)void (^setPasswordSuccessBlock)(void);

@end

NS_ASSUME_NONNULL_END

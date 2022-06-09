//
//  CleanAlertViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/25.
//

#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CleanAlertViewController : BaseAlertViewController

@property (nonatomic , strong)void(^viewBlock)(void);

@end

NS_ASSUME_NONNULL_END

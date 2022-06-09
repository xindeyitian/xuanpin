//
//  BingdingAlertViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/26.
//

#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BingdingAlertViewController : BaseAlertViewController

@property (nonatomic , strong)void(^btnClickBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END

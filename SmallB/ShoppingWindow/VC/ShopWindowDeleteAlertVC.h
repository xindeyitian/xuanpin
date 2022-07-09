//
//  ShopWindowDeleteAlertVC.h
//  SmallB
//
//  Created by zhang on 2022/7/8.
//

#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopWindowDeleteAlertVC : BaseAlertViewController

@property (nonatomic , strong)void(^confirmBtnClickBlock)(void);

@end

NS_ASSUME_NONNULL_END

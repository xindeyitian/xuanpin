//
//  PproductShareWarningViewController.h
//  SmallB
//
//  Created by zhang on 2022/7/19.
//

#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductShareWarningViewController : BaseAlertViewController
@property (nonatomic, strong)void(^confirmBlock)(void);

@end

NS_ASSUME_NONNULL_END

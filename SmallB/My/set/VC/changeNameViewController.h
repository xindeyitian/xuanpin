//
//  changeNameViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface changeNameViewController : BaseAlertViewController

@property (nonatomic , strong)void(^viewBlock)(NSString *name);
@property (nonatomic , strong)NSString *nameStr;

@end

NS_ASSUME_NONNULL_END

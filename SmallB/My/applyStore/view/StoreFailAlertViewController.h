//
//  StoreFailAlertViewController.h
//  SmallB
//
//  Created by zhang on 2022/6/16.
//

#import "BaseAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreFailAlertViewController : BaseAlertViewController

@property (nonatomic , strong)NSDictionary *applyInfoDic;
@property (nonatomic , copy)NSString *content;

@end

NS_ASSUME_NONNULL_END

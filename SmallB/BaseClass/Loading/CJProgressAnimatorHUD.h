//
//  CJProgressAnimatorHUD.h
//  CJ Dropshipping
//
//  Created by Architray on 2020/4/21.
//  Copyright © 2020 CuJia. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJProgressAnimatorHUD : MBProgressHUD

/**
 在目标视图上生成loading视图
 视图不会重复, 如果目标视图上已经有loading, 则重用并重新配置
 
 如果需要重复创建,则使用showHUDAddedTo:animated:
 */
+ (instancetype)showNoRepeatHUDAddedTo:(UIView *)view animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

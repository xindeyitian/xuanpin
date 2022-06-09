//
//  BaseAlertViewController.h
//  SmallB
//
//  Created by zhang on 2022/4/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAlertViewController : THBaseViewController

@property (nonatomic, weak) UIView *bgView;

- (THBaseViewController *)currentVC;

@end

NS_ASSUME_NONNULL_END

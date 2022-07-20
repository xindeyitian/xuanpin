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
@property (nonatomic, assign)BOOL notEnabled;//yes不能点击背景消失

- (THBaseViewController *)currentVC;

@end

NS_ASSUME_NONNULL_END

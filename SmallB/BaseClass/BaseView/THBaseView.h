//
//  THBaseView.h
//  LLWFan
//
//  Created by MAC on 2022/3/21.
//

#import <UIKit/UIKit.h>
#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface THBaseView : UIView

/**
 当前显示的控制器
 
 @return 控制器
 */
- (THBaseViewController *)currentViewController;


@end

NS_ASSUME_NONNULL_END

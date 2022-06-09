//
//  UITableViewCell+currentVC.h
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/5.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THBaseViewController.h"
@interface UITableViewCell (currentVC)
/**
 当前显示的控制器
 
 @return 控制器
 */
- (THBaseViewController *)currentViewController;
@end

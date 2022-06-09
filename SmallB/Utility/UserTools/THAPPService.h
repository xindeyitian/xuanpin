//
//  THAPPService.h
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/3.
//  Copyright © 2017年 王剑亮. All rights reserved.
//


//用于获取当前的控制器和设置window的主控制器
#import <Foundation/Foundation.h>
#import "THBaseViewController.h"
@interface THAPPService : NSObject


/**
 单例创建
 
 @return SCAppInfoHelper
 */
+ (instancetype)shareAppService;


/**
 当前的主控制器

 @return 当前的主控制器
 */
+ (UIViewController *)WindowRootViewController;


/**
 设置当前主控制器

 @param VC 设置当前主控制器
 */
+ (void)setWindowRootViewController:(UIViewController *)VC;

/**
 当前显示的控制器
 */
@property(nonatomic,weak) THBaseViewController *currentViewController;

@end

//
//  THBaseViewController.h
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/3.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@interface THBaseViewController : UIViewController

@property(nonatomic , strong)void(^currentVCBlock)(NSString *string);

///**
// 网络链接变化的通知
//
// @param note 通知
// @return 网络链接状态
// */
- (void)AFNetworkingReachabilityDidChang:(NSNotification *)note;

/**
 导航栏左边按钮
 */
@property(nonatomic,strong)  UIBarButtonItem *leftButtonItem;


/**
 导航栏右边按钮
 */
@property(nonatomic,strong)  UIBarButtonItem *rightButtonItem;

@property(nonatomic,strong)  UILabel *barTitleL;

/**
 
 view布局
 */
- (void)initView;

#pragma mark 返回按钮
- (void)returnAction;



/**
 进入前台
 */
- (void)applicationWillEnterForeground;


/**
 进入后台
 */
- (void)applicationDidEnterBackground;


/** 程序被杀死 */
-(void)applicationWillTerminate;

- (void)startLoadingHUD;
- (void)stopLoadingHUD;

- (void)showMessageWithString:(NSString *)warningStr;

- (void)showSuccessMessageWithString:(NSString *)content;

- (void)showErrorMessageWithString:(NSString *)content;

@end

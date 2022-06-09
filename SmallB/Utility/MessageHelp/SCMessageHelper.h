//
//  SCMessageHelper.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/2/18.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SCMessageHelper : NSObject


/**
 显示消息

 @param message 提示消息
 */
+ (void)showMessage:(NSString *)message;


/**
 自动消失的提示

 @param message 提示消息
 */
+ (void)showAutoMessage:(NSString *)message;

+ (void)showAutoMessage:(NSString *)message block:(void(^)(UIAlertView *alert, NSInteger buttonIndex))block;

@end

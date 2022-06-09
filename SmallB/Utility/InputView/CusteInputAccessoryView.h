//
//  custeInputAccessoryView.h
//  CreditManager
//
//  Created by 李经纬 on 2017/8/31.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShowCodeView.h"

@protocol CusteInputAccessoryViewDelegate <NSObject>

@required
/**
 当到达设定位数时,返回输入值内容
 */
- (void)achieveTargetNumber:(NSString *)code;


@optional;

/**
 忘记密码
 */
- (void)forgetAction;




@end

@interface CusteInputAccessoryView : UIView

@property (nonatomic, assign) id<CusteInputAccessoryViewDelegate> delegate;

/**
 输入框颜色
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 输入框边距
 */
@property (nonatomic, assign) CGFloat rectViewGap;

/**
 控制验证码/密码是否密文显示
 */
@property (nonatomic, assign) BOOL secureTextEntry;

/**
 提示标题
 */
@property (nonatomic, copy) NSString *title;

/**
 背景图片
 */
@property (nonatomic, copy) NSString *backgroudImageName;

/**
 验证码/密码的位数
 */
@property (nonatomic, assign) NSInteger numberOfVertificationCode;

/**
 验证码/密码内容，可以通过该属性拿到验证码/密码输入框中验证码/密码的内容
 */
@property (nonatomic, copy) NSString *vertificationCode;

/**
 设置圆角
 */
@property (nonatomic, assign) BOOL isRounded;

/**
 是否显示忘记密码按钮
 */
@property (nonatomic, assign) BOOL isShowForgetButton;

/**
 是否显示取消按钮
 */
@property (nonatomic, assign) BOOL isShowCancelButton;

/**
 提示内容
 */
@property (nonatomic, copy) NSString *promptText;

/** 清除信息*/
- (void)cleanCode;

/**
 开始相应
 */
- (BOOL)becomeFirstResponder;

/**
 放弃响应
 */
- (BOOL)resignFirstResponder;


@end

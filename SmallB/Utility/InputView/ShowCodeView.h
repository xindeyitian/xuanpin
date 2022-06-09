//
//  ShowCodeView.h
//  ZhongbenKaGuanJia
//
//  Created by 李经纬 on 2018/8/16.
//  Copyright © 2018年 李经纬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THBaseView.h"

@protocol ShowCodeViewDelegate <NSObject>

@optional;
- (void)achieveTargetNumber:(NSString *)code;

@end

@interface ShowCodeView : THBaseView

/**输入框颜色*/
@property (nonatomic, strong) UIColor *borderColor;
/**输入框边距*/
@property (nonatomic, assign) CGFloat rectViewGap;
/**控制验证码/密码是否密文显示*/
@property (nonatomic, assign) BOOL secureTextEntry;
/**背景图片*/
@property (nonatomic, copy) NSString *backgroudImageName;
/**验证码/密码的位数*/
@property (nonatomic, assign) NSInteger numberOfVertificationCode;
/**验证码/密码内容，可以通过该属性拿到验证码/密码输入框中验证码/密码的内容*/
@property (nonatomic, copy) NSString *vertificationCode;
/**设置圆角*/
@property (nonatomic, assign) BOOL isRounded;

@property (nonatomic, assign) id<ShowCodeViewDelegate> delegate;

/**用于获取键盘输入的内容，实际不显示*/
@property (nonatomic, strong) UITextField *textField;

/** 清除信息*/
- (void)cleanCode;



@end

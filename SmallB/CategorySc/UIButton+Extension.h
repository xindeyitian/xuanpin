//
//  UIButton+Extension.h
//  ZBank
//
//  Created by sundan on 2017/5/17.
//  Copyright © 2017年 yonyou. All rights reserved.
//


#import <UIKit/UIKit.h>

//按钮禁止连续点击,设置相应时间

@interface UIButton (Extension)

@property (nonatomic, copy) NSString *timeStr;

@property (nonatomic, copy) NSString *defaultDuration;//响应时间间隔

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;


/**
 设置按钮的 可点击的状态

 @param btn 按钮
 @param isEnabeld 可以点击 或者 不可以点击
 */
+ (void)setNewVesionBtnEnabeld:(UIButton *)btn status:(BOOL)isEnabeld;

+ (void)setButtonContentCenter:(UIButton *) btn;

@end

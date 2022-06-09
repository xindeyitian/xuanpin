//
//  UIViewController+CustomTransitonAnimation.m
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/11.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "UIViewController+CustomTransitionAnimation.h"

@implementation UIViewController (CustomTransitonAnimation)

//pageCurl            向上翻一页
//pageUnCurl          向下翻一页
//rippleEffect        滴水效果
//suckEffect          收缩效果，如一块布被抽走
//cube                立方体效果
//oglFlip             上下翻转效果
// push              推出

- (void)customTransition{

    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //设置动画类型为立方体动画
    animation.type = @"rippleEffect";
    //设置动画时长
    animation.duration = 0.5f;
    //设置运动的方向
    animation.subtype =kCATransitionFromRight;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
}

@end

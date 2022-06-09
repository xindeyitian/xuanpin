//
//  UIView+SCLayerAnimation.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/2/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCLayerAnimation)


/**
 推荐地址的水波纹
 */
- (void)recommendWaterRippleAtPoint:(CGPoint)point;

/**
 定位的水波纹
 */
- (void)waterRippleLocation;


/**
 等待订单的水笔纹
 */
- (void)waterRippleWaiting;


/**
 水波纹的起始点

 @param size 起始点
 */
- (void)waterRippleWaitingInSize:(CGFloat)size;
@end

//
//  CALayer+SCFrame.h
//  LDSpecialCarService
//
//  Created by Mac on 2017/5/11.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (SCFrame)

/**
 bounds中心点
 
 @return bounds中心点坐标
 */
- (CGPoint)boundsCenter;
- (CGFloat)boundsCenterX;
- (CGFloat)boundsCenterY;

/**
 视图的坐标
 
 @return 视图的坐标
 */
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;


/**
 视图的尺寸
 
 @return 视图的尺寸
 */
- (CGSize)size;
- (void)setSize:(CGSize)size;

/**
 view的宽
 
 @return 宽
 */
- (CGFloat)width;

- (void)setWidth:(CGFloat)width;

/**
 view的高
 
 @return 高
 */
- (CGFloat)height;

- (void)setHeight:(CGFloat)height;

/**
 view的x坐标
 
 @return x坐标
 */
- (CGFloat)x;

- (void)setX:(CGFloat)x;

- (CGFloat)maxX;

- (CGFloat)midX;

- (void)setMidX:(CGFloat)midX;

/**
 view的y坐标
 
 @return y坐标
 */
- (CGFloat)y;

- (void)setY:(CGFloat)y;

- (CGFloat)maxY;

- (void)setMaxY:(CGFloat)maxY;

- (CGFloat)midY;

- (void)setMidY:(CGFloat)midY;

@end

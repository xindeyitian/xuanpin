//
//  UIView+SCFrame.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/1/19.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIView+SCFrame.h"

@implementation UIView (SCFrame)

- (CGPoint)boundsCenter
{
    CGPoint center = self.center;

    center.x -= self.x;
    
    center.y -= self.y;
    
    return center;
}
- (CGFloat)boundsCenterX
{
    CGPoint point = [self boundsCenter];
    
    return point.x;
}
- (CGFloat)boundsCenterY
{
    CGPoint point = [self boundsCenter];
    
    return point.y;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    
    frame.origin = origin;
    
    self.frame = frame;
}

- (CGSize)size
{

    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;
}

- (CGFloat)width
{

    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame = frame;
}

- (CGFloat)height
{

    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    
    frame.size.height = height;
    
    self.frame = frame;
}

- (CGFloat)x
{
     return self.frame.origin.x;
}

- (CGFloat)maxX
{

    return CGRectGetMaxX(self.frame);
}

- (CGFloat)midX
{

    return CGRectGetMidX(self.frame);
}

- (void)setMidX:(CGFloat)midX
{
    CGPoint center = self.center;
    
    center.x = midX;
    
    self.center = center;
}

- (void)setX:(CGFloat)x
{
    
    CGRect frame = self.frame;
    
    frame.origin.x = x;
    
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY
{
    
    if (maxY>self.y) {
        
        self.height = maxY - self.y;
    }
}

- (CGFloat)midY
{

    return CGRectGetMidY(self.frame);
}

- (void)setMidY:(CGFloat)midY
{
    CGPoint center = self.center;
    
    center.y = midY;
    
    self.center = center;
}
- (void)setY:(CGFloat)y
{
    
    CGRect frame = self.frame;
    
    frame.origin.y = y;
    
    self.frame = frame;
}
@end

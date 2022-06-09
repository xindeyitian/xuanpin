//
//  UIView+SCLayerAnimation.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/2/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIView+SCLayerAnimation.h"
#import <objc/runtime.h>


@implementation UIView (SCLayerAnimation)


- (CAAnimationGroup *)groupAnimation
{
    //动画 透明度变化
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    
    //动画 大小变化
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    //组动画
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 1;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = 1;
    
    return groupAnima;
}

- (CAShapeLayer *)pulseLayer
{
    
    CAShapeLayer *pulseLayer = objc_getAssociatedObject(self, @"pulseLayer");
    
    if (!pulseLayer) {
        
         CGPoint point = self.center;
        //脉冲
        pulseLayer = [CAShapeLayer layer];
        pulseLayer.frame = CGRectMake(0, 0, 50, 50);
        pulseLayer.position = point;
        pulseLayer.anchorPoint = CGPointMake(0.5, 0.5);
        pulseLayer.path = [UIBezierPath bezierPathWithRoundedRect:pulseLayer.bounds cornerRadius:25].CGPath;
        pulseLayer.fillColor = [UIColor blueColor].CGColor;
        pulseLayer.opacity = 0.0;
        
        objc_setAssociatedObject(self, @"pulseLayer", pulseLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self.layer addSublayer:pulseLayer];
    }
    
    return pulseLayer;
}

- (void)waterRippleLocation
{
    CGPoint point = self.center;
    
    self.pulseLayer.position = point;
    
    [self.pulseLayer removeAllAnimations];
    
    [self.pulseLayer addAnimation:self.groupAnimation forKey:@"groupAnimation"];
}

- (void)recommendWaterRippleAtPoint:(CGPoint)point
{
    //脉冲
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = CGRectMake(0, 0, 30, 30);
    pulseLayer.position = point;
    pulseLayer.anchorPoint = CGPointMake(0.5, 0.5);
    pulseLayer.path = [UIBezierPath bezierPathWithRoundedRect:pulseLayer.bounds cornerRadius:25].CGPath;
    pulseLayer.fillColor = [UIColor blueColor].CGColor;
    pulseLayer.opacity = 0.0;
    
    [self.layer addSublayer:pulseLayer];
    
    CAAnimationGroup *animation = self.groupAnimation;
    
    animation.repeatCount = HUGE;
    
    [pulseLayer addAnimation:animation forKey:@"groupAnimation"];
}

- (void)waterRippleWaiting
{
 
    [self waterRippleWaitingInSize:0];
}

- (void)waterRippleWaitingInSize:(CGFloat)size
{
    CGPoint center = self.center;
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    CGFloat width = self.frame.size.width*0.9;
    pulseLayer.frame = CGRectMake(center.x - width/2, center.y - width/2, width, width);
    pulseLayer.path = [UIBezierPath bezierPathWithRoundedRect:pulseLayer.bounds cornerRadius:width/2].CGPath;
    pulseLayer.fillColor = [UIColor hexChangeFloat:@"266dd7"].CGColor;
    pulseLayer.opacity = 0.0;
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.6);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, size/width, size/width, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.bounds;
    replicatorLayer.instanceCount = 4;
    replicatorLayer.instanceDelay = 1;
    //    replicatorLayer.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 10, 10, 0);
    [replicatorLayer addSublayer:pulseLayer];
    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    maskLayer.frame = pulseLayer.bounds;
//    maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size, size)].CGPath;
//    maskLayer.fillColor = [UIColor clearColor].CGColor;
//    maskLayer.strokeColor = [UIColor blueColor].CGColor;
   
    [self.layer addSublayer:replicatorLayer];
    
}
@end

//
//  UIColor+SCRandomColor.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/2/23.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIColor+SCRandomColor.h"

@implementation UIColor (SCRandomColor)

+ (instancetype)randomColor
{
    CGFloat R = arc4random_uniform(256)/255.0;
    
    CGFloat G = arc4random_uniform(256)/255.0;
    
    CGFloat B = arc4random_uniform(256)/255.0;
    
    
    UIColor *color = [UIColor colorWithRed:R green:G blue:B alpha:1];
    
    return color;
}
@end

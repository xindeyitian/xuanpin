//
//  CALayer+XibBorder.m
//  palmlife
//
//  Created by MAC on 2019/12/16.
//  Copyright © 2019 王剑亮. All rights reserved.
//

#import "CALayer+XibBorder.h"

@implementation CALayer (XibBorder)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    
    self.borderColor = color.CGColor;
    
}

@end

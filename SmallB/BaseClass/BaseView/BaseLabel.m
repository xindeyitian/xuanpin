//
//  BaseLabel.m
//  BaseDemo
//
//  Created by 王剑亮 on 2017/8/22.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "BaseLabel.h"

@implementation BaseLabel

+ (BaseLabel *)CreateBaseLabelStr :(NSString *)str
                             Font :(UIFont *)font
                            Color :(UIColor *)color
                            Frame :(CGRect )frame
                        Alignment :(NSTextAlignment)textAlignment
                              Tag :(NSInteger)tag{

    BaseLabel *label = [[BaseLabel alloc]init];
    label.text = str;
    label.tag = tag;
    label.font =  font;
    label.textColor = color;
    label.frame = frame;
    label.textAlignment = textAlignment;
   
    return label;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

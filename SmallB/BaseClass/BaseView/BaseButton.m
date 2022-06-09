//
//  BaseButton.m
//  BaseDemo
//
//  Created by 王剑亮 on 2017/8/22.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

+ (nullable BaseButton *)CreateBaseButtonTitle:(nullable NSString *)title
                                        Target:(nullable id)target
                                        Action:(nullable SEL)action
                                          Font:(nullable UIFont *)font
                               BackgroundColor:(nullable UIColor *)bgColor
                                        Color :(nullable UIColor *)color
                                         Frame:(CGRect )frame
                                     Alignment:(NSTextAlignment)textAlignment
                                           Tag:(NSInteger)tag{

    BaseButton *btn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    btn.titleLabel.textAlignment = textAlignment;
    btn.frame = frame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag =  tag;
    btn.backgroundColor =bgColor;
    
    return btn;
}
+ (nullable BaseButton *)CreateBaseButtonTitle:(nullable NSString *)title
                                        Target:(nullable id)target
                                        Action:(nullable SEL)action
                                          Font:(nullable UIFont *)font
                                         Frame:(CGRect )frame
                                     Alignment:(NSTextAlignment)textAlignment
                                           Tag: (NSInteger)tag
                               BackgroundImage:(nullable NSString *)imageName
                    HeightLightBackgroundImage:(nullable NSString *)heightLightImageName{
    
    BaseButton *btn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font =   font;
    btn.frame = frame;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tag =  tag;
    [btn setAdjustsImageWhenDisabled:NO];
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName]forState:UIControlStateNormal];
    //创建高亮或选中状态按钮图片
    [btn setImage:[UIImage imageNamed:heightLightImageName]forState:UIControlStateHighlighted];
    
    CGFloat totalHeight =(btn.imageView.frame.size.height + btn.titleLabel.frame.size.height);
    [btn setImageEdgeInsets:UIEdgeInsetsMake((totalHeight - btn.imageView.frame.size.height),0.0,0.0, -btn.titleLabel.frame.size.width)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, btn.imageView.frame.size.width, -(totalHeight - btn.titleLabel.frame.size.height),0.0)];
    
    return btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

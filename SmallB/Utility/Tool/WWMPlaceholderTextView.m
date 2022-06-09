//
//  WWMPlaceholderTextView.m
//  WildFireChat
//
//  Created by 杨晓铭 on 2020/11/24.
//  Copyright © 2020 WildFireChat. All rights reserved.
//

#import "WWMPlaceholderTextView.h"

@implementation WWMPlaceholderTextView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //设置默认字体
        self.font = [UIFont systemFontOfSize:14];
        //设置默认颜色
        self.placeholderColor = [UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0];
        
        //使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

//监听文字改变
- (void)textDidChange:(NSNotification *)notification{
    
    //重新调用drawRect：方法
    [self setNeedsDisplay];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 调用drawRect

 @param rect 每次都会将以前的东西清除掉
 */
- (void)drawRect:(CGRect)rect{
    //如果有文字，直接返回，不需要占位文字
    if (self.hasText) {
        return;
    }
    
    //属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    //画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2*rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

#pragma mark -------setter
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}


@end

//
//  BaseLabel.h
//  BaseDemo
//
//  Created by 王剑亮 on 2017/8/22.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLabel : UILabel

+ (BaseLabel *)CreateBaseLabelStr :(NSString *)str
                                             Font :(UIFont *)font
                                            Color :(UIColor *)color
                                           Frame :(CGRect )frame
                                     Alignment :(NSTextAlignment)textAlignment
                                              Tag :(NSInteger)tag;

@end

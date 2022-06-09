//
//  BaseButton.h
//  BaseDemo
//
//  Created by 王剑亮 on 2017/8/22.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseButton : UIButton

+ (nullable BaseButton *)CreateBaseButtonTitle:(nullable NSString *)title
                                                Target:(nullable id)target
                                                Action:(nullable SEL)action
                                                Font:(nullable UIFont *)font
                                                BackgroundColor:(nullable UIColor *)bgColor
                                                Color :(nullable UIColor *)color
                                                Frame:(CGRect )frame
                                                Alignment:(NSTextAlignment)textAlignment
                                                Tag : (NSInteger)tag;

+ (nullable BaseButton *)CreateBaseButtonTitle:(nullable NSString *)title
                                        Target:(nullable id)target
                                        Action:(nullable SEL)action
                                          Font:(nullable UIFont *)font
                                         Frame:(CGRect )frame
                                     Alignment:(NSTextAlignment)textAlignment
                                           Tag: (NSInteger)tag
                               BackgroundImage:(nullable NSString *)imageName
                    HeightLightBackgroundImage:(nullable NSString *)heightLightImageName;
@end

//
//  UIFont+SCConfigFont.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/3/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIFont+SCConfigFont.h"

//#define  HiraginoSansW3     @"HiraginoSans-W3"
#define  HiraginoSansW3   [UIFont systemFontOfSize:14].fontName


@implementation UIFont (SCConfigFont)

+ (instancetype)mainFont27
{

    return [UIFont systemFontOfSize:27];
}
+ (instancetype)mainFont18
{
    return [UIFont systemFontOfSize:18];
}
+ (instancetype)mainFont17
{
    return [UIFont systemFontOfSize:17];
}

+ (instancetype)mainFont15
{
    return [UIFont systemFontOfSize:15];
}

+ (instancetype)mainFont13
{
    return [UIFont systemFontOfSize:13];
}
+ (instancetype)mainFont12
{
    return [UIFont systemFontOfSize:12];
}

+ (instancetype)mainFont11
{
    return [UIFont systemFontOfSize:11];
}


+ (instancetype)numberFont55{
    return [UIFont systemFontOfSize:55];
}
+ (instancetype)numberFont45{
    return [UIFont systemFontOfSize:45];
}
+ (instancetype)numberFont30{
    return [UIFont systemFontOfSize:30];
}
+ (instancetype)numberFont25{
    return [UIFont systemFontOfSize:25];
}

@end

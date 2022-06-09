//
//  NSString+stringtoRect.m
//  test
//
//  Created by 王剑亮 on 2016/8/11.
//  Copyright © 2016年 王剑亮. All rights reserved.
//

#import "NSString+stringtoRect.h"

@implementation NSString (stringtoRect)
#pragma mark - 自适应高度
- (CGRect)stringHeighWithfontSize:(CGFloat)fontSize contentSize:(CGSize)size
{
    //第一个参数，代表最大的范围
    //第二个参数，代表的是 是否考虑字体，是否考虑字号
    //第三个参数，代表的是使用什么字体什么字号
    //第四个参数，用不到，所以基本上是nil
    CGRect stringRect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return stringRect;
}
@end

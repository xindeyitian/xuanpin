//
//  NSString+stringtoRect.h
//  test
//
//  Created by 王剑亮 on 2016/8/11.
//  Copyright © 2016年 王剑亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (stringtoRect)


#pragma mark ----- UILable 文字转化成对应的Frame 在TableView 计算文字Lable高度和宽度常用
- (CGRect)stringHeighWithfontSize:(CGFloat)fontSize contentSize:(CGSize)size;

@end

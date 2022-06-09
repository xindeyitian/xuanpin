//
//  UITextField+Extension.h
//  ZBank
//
//  Created by sundan on 2017/5/17.
//  Copyright © 2017年 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>

//字数限制

@interface UITextField (Extension)

@property (nonatomic, copy) NSString *len;

- (void)addTextLengthLimitWithLength:(NSInteger)length;

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

@end

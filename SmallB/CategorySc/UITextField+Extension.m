//
//  UITextField+Extension.m
//  ZBank
//
//  Created by sundan on 2017/5/17.
//  Copyright © 2017年 yonyou. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>

static const void *lenKey = &lenKey;

@implementation UITextField (Extension)

@dynamic len;


- (NSString *)len {
    return objc_getAssociatedObject(self, lenKey);
}

- (void)setLen:(NSString *)len {
    return objc_setAssociatedObject(self, lenKey, len, 1);
}


- (void)addTextLengthLimitWithLength:(NSInteger)length {
    self.len = [NSString stringWithFormat:@"%ld",length];
     [self addTarget:self action:@selector(tfEditing:) forControlEvents:(UIControlEventEditingChanged)];
}

#pragma mark - textfield编辑
- (void)tfEditing:(UITextField *)tf {
    NSInteger len = [self convertToInt:tf.text];
    if (len > [self.len integerValue] && [self.len integerValue] != 0) {
        //截取前面的tfTextLenght位数
        tf.text = [tf.text substringToIndex:[self.len integerValue]];
    }
}

//判断中英混合的的字符串长度
- (NSInteger)convertToInt:(NSString *)strtemp
{
    NSInteger strlength = 0;
    for (int i = 0; i< [strtemp length]; i++) {
        int a = [strtemp characterAtIndex:i];
        //判断是否为中文
        if( a > 0x4e00 && a < 0x9fff) {
            strlength += 2;
        }
        else{
            strlength += 1;
        }
    }
    return strlength;
}

// 选中的字符串的起始位置,与选中的字符串的长度
- (NSRange) selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

// 选中的字符串的范围
- (void) setSelectedRange:(NSRange) range
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}
@end

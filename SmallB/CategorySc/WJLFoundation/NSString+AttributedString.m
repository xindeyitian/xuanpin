//
//  NSString+AttributedString.m
//  Present
//
//  Created by liu_cong on 16/8/26.
//  Copyright © 2016年 ll. All rights reserved.
//

#import "NSString+AttributedString.h"

@implementation NSString (AttributedString)

-(NSMutableAttributedString *)changeColorWithColor:(UIColor *)color SubStringArray:(NSArray *)subArray{
    NSMutableAttributedString *attributedArr = [[NSMutableAttributedString alloc]initWithString:self];
    for (NSString *rangeStr in subArray) {
        NSRange range = [self rangeOfString:rangeStr  options:NSBackwardsSearch];
        [attributedArr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return attributedArr;
}

-(NSMutableAttributedString *)changeSpace:(CGFloat)space{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    long number = space;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    return attributedStr;
}

-(NSMutableAttributedString *)changeLineSpaceWithLineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    return attributedStr;
}

-(NSMutableAttributedString *)changeLineAndTextSpaceWithLineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    long number = textSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    return attributedStr;
}


-(NSMutableAttributedString *)changeFontAndColor:(UIFont *)font Color:(UIColor *)color SubStringArray:(NSArray *)subArray {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
    for (NSString *rangeStr in subArray) {
        NSRange range = [self rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedStr;
}

-(NSMutableAttributedString *)InitFont:(UIFont *)initFont  InitColor: (UIColor *)initColor    changeFontAndColor:(UIFont *)font Color:(UIColor *)color SubStringArray:(NSArray *)subArray {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
      [attributedStr addAttribute:NSFontAttributeName value:initFont range:NSMakeRange(0, self.length)];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:initColor range:NSMakeRange(0, self.length)];
    for (NSString *rangeStr in subArray) {
        NSRange range = [self rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    return attributedStr;
}


@end
